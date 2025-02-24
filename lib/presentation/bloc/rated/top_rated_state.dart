import '../../../domain/entities/movie.dart';

abstract class TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedLoaded extends TopRatedState {
  final List<Movie> movies;
  TopRatedLoaded(this.movies);
}

class TopRatedError extends TopRatedState {
  final String message;
  TopRatedError(this.message);
}
