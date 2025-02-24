import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../models/movie_model.dart';
import '../../../core/network/api_config.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/discover/movie")
  Future<MovieResponse> getPopularMovies(
      @Query("language") String language,
      @Query("page") int page,
      @Query("sort_by") String sortBy,
      @Query("include_adult") bool includeAdult,
      @Query("include_video") bool includeVideo,
      );
}
