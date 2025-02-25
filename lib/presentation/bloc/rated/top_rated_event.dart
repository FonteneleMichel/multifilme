import 'package:equatable/equatable.dart';

abstract class TopRatedEvent extends Equatable {
  const TopRatedEvent();
}

class FetchTopRatedMovies extends TopRatedEvent {
  final String language;

  const FetchTopRatedMovies(this.language);

  @override
  List<Object> get props => [language];
}
