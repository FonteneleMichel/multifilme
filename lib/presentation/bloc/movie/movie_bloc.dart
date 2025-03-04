import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;

  MovieBloc(this.repository) : super(MovieLoading()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      try {
        final movies = await repository.getNowPlayingMovies(event.language);
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError("Erro ao carregar filmes nos cinemas"));
      }
    });

    on<FetchUpcomingMovies>((event, emit) async {
      try {
        final movies = await repository.getUpcomingMovies(event.language);
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError("Erro ao carregar filmes em breve"));
      }
    });

    on<FetchPopularMovies>((event, emit) async {
      try {
        final movies = await repository.getPopularMovies(event.language, 1);
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError("Erro ao carregar filmes populares"));
      }
    });
  }
}
