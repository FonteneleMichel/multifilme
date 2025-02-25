import 'dart:ui';

abstract class MovieDetailEvent {}

class FetchMovieDetail extends MovieDetailEvent {
  final int movieId;
  final String language;

  FetchMovieDetail(this.movieId, this.language);
}
