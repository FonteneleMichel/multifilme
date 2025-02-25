import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchNowPlayingMovies extends MovieEvent {
  final String language; // Agora recebe o idioma como String

  const FetchNowPlayingMovies(this.language);

  @override
  List<Object> get props => [language];
}

class FetchUpcomingMovies extends MovieEvent {
  final String language; // Agora recebe o idioma como String

  const FetchUpcomingMovies(this.language);

  @override
  List<Object> get props => [language];
}

class FetchPopularMovies extends MovieEvent {
  final String language; // Agora recebe o idioma como String

  const FetchPopularMovies(this.language);

  @override
  List<Object> get props => [language];
}
