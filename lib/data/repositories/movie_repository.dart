import '../datasources/remote/api_service.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';

class MovieRepository {
  final ApiService apiService;

  MovieRepository(this.apiService);

  Future<List<Movie>> getPopularMovies(String language, int page) async {
    final response = await apiService.getPopularMovies(
      language,
      page,
      "popularity.desc",
      false,
      false,
    );
    return response.results.map((movie) => Movie.fromModel(movie)).toList();
  }

  Future<List<Movie>> getNowPlayingMovies(String language) async {
    final response = await apiService.getNowPlayingMovies(language, 1);
    return response.results.map((movie) => Movie.fromModel(movie)).toList();
  }

  Future<List<Movie>> getUpcomingMovies(String language) async {
    final response = await apiService.getUpcomingMovies(language, 1);
    return response.results.map((movie) => Movie.fromModel(movie)).toList();
  }

  Future<List<Movie>> getTopRatedMovies(String language) async {
    final response = await apiService.getTopRatedMovies(language, 1);
    return response.results.take(4).map((movie) => Movie.fromModel(movie)).toList();
  }

  Future<MovieDetail> getMovieDetails(int movieId, String language) async {
    final response = await apiService.getMovieDetails(movieId, language, "videos");
    return MovieDetail.fromModel(response);
  }
}
