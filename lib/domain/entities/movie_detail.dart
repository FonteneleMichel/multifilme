import 'package:multifilme/data/models/movie_detail_model.dart';

class MovieDetail {
  final int id;
  final String title;
  final String originalTitle;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final String overview;
  final List<String> genres;
  final List<String> productionCountries;
  final int? budget;
  final String? trailerKey;

  MovieDetail({
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
    this.trailerKey,
  });

  factory MovieDetail.fromModel(MovieDetailModel model) {
    return MovieDetail(
      id: model.id,
      title: model.title,
      originalTitle: model.originalTitle,
      releaseDate: model.releaseDate,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
      overview: model.overview,
      genres: model.genres.map((g) => g.name).toList(),
      productionCountries: model.productionCountries.map((c) => c.name).toList(),
      budget: model.budget,
      trailerKey: model.videos.results.isNotEmpty
          ? model.videos.results.firstWhere(
            (video) => video.type == "Trailer" && video.site == "YouTube",
        orElse: () => VideoModel(key: "", site: "", type: ""),
      ).key
          : null,
    );
  }
}
