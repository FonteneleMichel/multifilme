import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/movie_repository.dart';
import 'top_rated_event.dart';
import 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final MovieRepository repository;

  TopRatedBloc(this.repository) : super(TopRatedLoading()) {
    on<FetchTopRatedMovies>((event, emit) async {
      try {
        final movies = await repository.getTopRatedMovies();
        emit(TopRatedLoaded(movies));
      } catch (e) {
        emit(TopRatedError("Erro ao carregar os melhores avaliados"));
      }
    });
  }
}
