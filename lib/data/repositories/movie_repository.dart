import '../datasources/remote/api_service.dart';
import '../../domain/entities/movie.dart';

class MovieRepository {
  final ApiService apiService;

  MovieRepository(this.apiService);

  Future<List<Movie>> getPopularMovies(int page) async {
    final response = await apiService.getPopularMovies(
      "pt-BR",
      page,
      "popularity.desc",
      false,
      false,
    );
    return response.results.map((movie) => Movie.fromModel(movie)).toList();
  }
}
