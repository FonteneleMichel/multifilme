import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../bloc/movie_state.dart';

class MovieListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filmes Populares")),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return ListTile(
                  leading: movie.posterPath != null
                      ? Image.network("https://image.tmdb.org/t/p/w200${movie.posterPath}")
                      : Icon(Icons.movie),
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
