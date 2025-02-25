import 'package:multifilme/data/models/movie_model.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromModel(MovieModel model) {
    return Movie(
      id: model.id,
      title: model.title,
      overview: model.overview,
      posterPath: model.posterPath,
      releaseDate: model.releaseDate,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
    );
  }
}
