import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../data/repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc(this.repository) : super(MovieLoading()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await repository.getPopularMovies(event.page);
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError("Erro ao carregar filmes: $e"));
      }
    });
    on<FetchTopRatedMovies>((event, emit) async {
      try {
        final topMovies = await repository.getTopRatedMovies();
        emit(TopRatedMoviesLoaded(topMovies));
      } catch (e) {
        emit(MovieError("Erro ao carregar os melhores avaliados"));
      }
    });
  }
}
