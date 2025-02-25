import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/movie_repository.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository repository;

  MovieDetailBloc(this.repository) : super(MovieDetailLoading()) {
    on<FetchMovieDetail>((event, emit) async {
      try {
        final movie = await repository.getMovieDetails(event.movieId);
        emit(MovieDetailLoaded(movie));
      } catch (e) {
        emit(MovieDetailError("Erro ao carregar detalhes do filme"));
      }
    });
  }
}
