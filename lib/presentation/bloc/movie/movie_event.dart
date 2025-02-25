abstract class MovieEvent {}

class FetchPopularMovies extends MovieEvent {
  final int page;

  FetchPopularMovies(this.page);
}

class FetchTopRatedMovies extends MovieEvent {}

class FetchNowPlayingMovies extends MovieEvent {}

class FetchUpcomingMovies extends MovieEvent {}

