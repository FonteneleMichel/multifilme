import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/localization/app_localizations.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_state.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).translate("app_title"))),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator()); // 🔄 Exibe um loader enquanto carrega
          } else if (state is MovieLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return ListTile(
                  leading: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.releaseDate ?? ''),
                );
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text(AppLocalizations.of(context).translate("error_loading_movies")));
          }
          return const Center(child: Text("Nenhum filme encontrado")); // Caso o estado seja desconhecido
        },
      ),
    );
  }
}
