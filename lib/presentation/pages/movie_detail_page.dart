import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multifilme/data/models/movie_detail_model.dart';
import 'package:multifilme/presentation/bloc/movie_detail_bloc.dart';
import 'package:multifilme/presentation/bloc/movie_detail_event.dart';
import 'package:multifilme/presentation/bloc/movie_detail_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class MovieDetailPage extends StatelessWidget {
  final int movieId;

  const MovieDetailPage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailBloc(context.read())..add(FetchMovieDetail(movieId)),
      child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              final movie = state.movie;

              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: movie.trailerKey != null && movie.trailerKey!.isNotEmpty
                        ? YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: movie.trailerKey!,
                        flags: const YoutubePlayerFlags(autoPlay: false),
                      ),
                    )
                        : const Center(child: Text("Trailer não disponível")),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text(movie.originalTitle, style: const TextStyle(fontSize: 18, color: Colors.grey)),
                        Text("Ano: ${movie.releaseDate.split('-')[0]}"),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            Text("${movie.voteAverage.toStringAsFixed(1)} - ${movie.voteCount} votos"),
                          ],
                        ),
                        Text("Gêneros: ${movie.genres.join(', ')}"),
                        Text("Resumo: ${movie.overview}"),
                        Text("Lançamento: ${movie.releaseDate}"),
                        Text("Origem: ${movie.productionCountries.join(', ')}"),
                        Text("Orçamento: \$${movie.budget?.toString() ?? 'Desconhecido'}"),

                        ElevatedButton(
                          onPressed: () async {
                            final url = "https://www.themoviedb.org/movie/${movie.id}";
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          child: const Text("Página Oficial"),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text("Erro ao carregar detalhes"));
          },
        ),
      ),
    );
  }
}
