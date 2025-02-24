abstract class MovieEvent {}

class FetchPopularMovies extends MovieEvent {
  final int page;

  FetchPopularMovies(this.page);
}
