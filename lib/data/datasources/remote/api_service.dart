import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../models/movie_response.dart';
import '../../models/movie_detail_model.dart';
import '../../../core/network/api_config.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/movie/now_playing")
  Future<MovieResponse> getNowPlayingMovies(
      @Query("language") String language,
      @Query("page") int page,
      );

  @GET("/movie/upcoming")
  Future<MovieResponse> getUpcomingMovies(
      @Query("language") String language,
      @Query("page") int page,
      );

  @GET("/discover/movie")
  Future<MovieResponse> getPopularMovies(
      @Query("language") String language,
      @Query("page") int page,
      @Query("sort_by") String sortBy,
      @Query("include_adult") bool includeAdult,
      @Query("include_video") bool includeVideo,
      );

  @GET("/movie/{movie_id}")
  Future<MovieDetailModel> getMovieDetails(
      @Path("movie_id") int movieId,
      @Query("language") String language,
      @Query("append_to_response") String appendToResponse,
      );

  @GET("/movie/top_rated")
  Future<MovieResponse> getTopRatedMovies(
      @Query("language") String language,
      @Query("page") int page,
      );
}
