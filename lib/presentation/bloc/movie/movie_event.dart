import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchNowPlayingMovies extends MovieEvent {
  final String language;

  const FetchNowPlayingMovies(this.language);

  @override
  List<Object> get props => [language];
}

class FetchUpcomingMovies extends MovieEvent {
  final String language;

  const FetchUpcomingMovies(this.language);

  @override
  List<Object> get props => [language];
}

class FetchPopularMovies extends MovieEvent {
  final String language;

  const FetchPopularMovies(this.language);

  @override
  List<Object> get props => [language];
}
