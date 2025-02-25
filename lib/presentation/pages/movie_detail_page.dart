import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multifilme/data/repositories/movie_repository.dart';
import 'package:multifilme/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:multifilme/presentation/bloc/detail/movie_detail_event.dart';
import 'package:multifilme/presentation/bloc/detail/movie_detail_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (context) => MovieDetailBloc(context.read<MovieRepository>())
        ..add(FetchMovieDetail(movieId)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/image/background.jpg",
                fit: BoxFit.cover,
              ),
            ),

            BlocBuilder<MovieDetailBloc, MovieDetailState>(
              builder: (context, state) {
                if (state is MovieDetailLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieDetailLoaded) {
                  final movie = state.movie;
                  String videoId = movie.trailerKey ?? "";
                  bool hasTrailer = videoId.isNotEmpty && videoId.runtimeType == String;

                  return Column(
                    children: [
                      if (hasTrailer)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: videoId,
                              flags: const YoutubePlayerFlags(
                                autoPlay: false,
                                mute: false,
                              ),
                            ),
                            bottomActions: [],
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                            progressColors: const ProgressBarColors(
                              playedColor: Colors.red,
                              handleColor: Colors.redAccent,
                            ),
                          ),
                        )
                      else
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              "Trailer não disponível",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),

                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.black.withOpacity(0.0),
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                    bottom: 100,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          movie.originalTitle,
                                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                                        ),
                                        const SizedBox(height: 8),

                                        Text("Ano: ${movie.releaseDate.split('-')[0]}",
                                            style: const TextStyle(color: Colors.white)),

                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              "${movie.voteAverage.toStringAsFixed(1)} - ${movie.voteCount} votos",
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 8),
                                        Text("Gêneros: ${movie.genres.join(', ')}",
                                            style: const TextStyle(color: Colors.white)),

                                        const SizedBox(height: 8),
                                        Text("Resumo:",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold, color: Colors.white)),
                                        Text(movie.overview, style: const TextStyle(color: Colors.white)),

                                        const SizedBox(height: 8),
                                        Text("Lançamento: ${movie.releaseDate}",
                                            style: const TextStyle(color: Colors.white)),
                                        Text("Origem: ${movie.productionCountries.join(', ')}",
                                            style: const TextStyle(color: Colors.white)),
                                        Text(
                                          "Orçamento: \$${movie.budget?.toString() ?? 'Desconhecido'}",
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 64,
                              left: 16,
                              right: 16,
                              child: Container(
                                width: 343,
                                height: 52,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF0E9FF3), Color(0xFF094B96)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final url = Uri.parse("https://www.themoviedb.org/movie/${movie.id}");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Página Oficial",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: Text("Erro ao carregar detalhes", style: TextStyle(color: Colors.white)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
