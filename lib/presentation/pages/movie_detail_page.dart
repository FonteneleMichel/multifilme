import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multifilme/data/repositories/movie_repository.dart';
import 'package:multifilme/presentation/bloc/movie_detail_bloc.dart';
import 'package:multifilme/presentation/bloc/movie_detail_event.dart';
import 'package:multifilme/presentation/bloc/movie_detail_state.dart';
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
        appBar: AppBar(
          title: const Text("Detalhes do Filme"),
          backgroundColor: Colors.black,
        ),
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailLoaded) {
              final movie = state.movie;

              // 🔥 Pegando o ID do trailer (garantindo que é String válida)
              String videoId = movie.trailerKey ?? "";
              bool hasTrailer = videoId.isNotEmpty && videoId.runtimeType == String;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // 🔥 Player do Trailer
                    if (hasTrailer)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
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

                    // 🔥 Informações do Filme
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Text(
                            movie.originalTitle,
                            style: const TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),

                          Text("Ano: ${movie.releaseDate.split('-')[0]}", style: const TextStyle(color: Colors.white)),

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
                          Text("Gêneros: ${movie.genres.join(', ')}", style: const TextStyle(color: Colors.white)),

                          const SizedBox(height: 8),
                          Text("Resumo:", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          Text(movie.overview, style: const TextStyle(color: Colors.white)),

                          const SizedBox(height: 8),
                          Text("Lançamento: ${movie.releaseDate}", style: const TextStyle(color: Colors.white)),
                          Text("Origem: ${movie.productionCountries.join(', ')}", style: const TextStyle(color: Colors.white)),
                          Text(
                            "Orçamento: \$${movie.budget?.toString() ?? 'Desconhecido'}",
                            style: const TextStyle(color: Colors.white),
                          ),

                          const SizedBox(height: 16),

                          // 🔥 Botão para Página Oficial
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                final url = Uri.parse("https://www.themoviedb.org/movie/${movie.id}");
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              child: const Text("Página Oficial", style: TextStyle(color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text("Erro ao carregar detalhes", style: TextStyle(color: Colors.white)),
            );
          },
        ),
      ),
    );
  }
}
