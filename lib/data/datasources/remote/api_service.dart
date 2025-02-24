import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../models/movie_model.dart';
import '../../../core/network/api_config.dart';

part 'api_service.g.dart'; // ⚠️ Certifique-se de que essa linha está aqui!

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService; // ⚠️ Isso só funciona se o arquivo .g.dart for gerado

  @GET("/movie/now_playing")
  Future<MovieResponse> getNowPlayingMovies(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") int page,
      );

  @GET("/movie/upcoming")
  Future<MovieResponse> getUpcomingMovies(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") int page,
      );

  @GET("/discover/movie")
  Future<MovieResponse> getPopularMovies(
      @Query("api_key") String apiKey,
      @Query("language") String language,
      @Query("page") int page,
      @Query("sort_by") String sortBy,
      @Query("include_adult") bool includeAdult,
      @Query("include_video") bool includeVideo,
      );
}
