import 'package:multifilme/domain/entities/movie_detail.dart';

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

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await apiService.getNowPlayingMovies(
      "pt-BR",
      1, // Página 1 por padrão
    );
    return response.results.map((movie) => Movie.fromModel(movie)).toList();
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await apiService.getUpcomingMovies(
      "pt-BR",
      1, // Página 1 por padrão
    );
    return response.results.map((movie) => Movie.fromModel(movie)).toList();
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await apiService.getTopRatedMovies("pt-BR", 1);
    return response.results.take(4).map((movie) => Movie.fromModel(movie)).toList();
  }

  Future<MovieDetail> getMovieDetails(int movieId) async {
    final response = await apiService.getMovieDetails(movieId, "pt-BR", "videos");
    return MovieDetail.fromModel(response);
  }
}
