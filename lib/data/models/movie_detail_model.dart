import 'package:json_annotation/json_annotation.dart';

part 'movie_detail_model.g.dart';

@JsonSerializable()
class MovieDetailModel {
  final int id;
  final String title;
  @JsonKey(name: "original_title")
  final String originalTitle;
  @JsonKey(name: "release_date")
  final String releaseDate;
  @JsonKey(name: "vote_average")
  final double voteAverage;
  @JsonKey(name: "vote_count")
  final int voteCount;
  final String overview;
  final List<GenreModel> genres;
  @JsonKey(name: "production_countries")
  final List<CountryModel> productionCountries;
  final int? budget;
  final MovieVideosModel videos;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.overview,
    required this.genres,
    required this.productionCountries,
    this.budget,
    required this.videos,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) => _$MovieDetailModelFromJson(json);
}

@JsonSerializable()
class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) => _$GenreModelFromJson(json);
}

@JsonSerializable()
class CountryModel {
  @JsonKey(name: "iso_3166_1")
  final String isoCode;
  final String name;

  CountryModel({required this.isoCode, required this.name});

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson(json);
}

@JsonSerializable()
class MovieVideosModel {
  final List<VideoModel> results;

  MovieVideosModel({required this.results});

  factory MovieVideosModel.fromJson(Map<String, dynamic> json) => _$MovieVideosModelFromJson(json);
}

@JsonSerializable()
class VideoModel {
  final String key;
  final String site;
  final String type;

  VideoModel({required this.key, required this.site, required this.type});

  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);
}
