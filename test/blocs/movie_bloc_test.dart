import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:multifilme/presentation/bloc/movie/movie_bloc.dart';
import 'package:multifilme/presentation/bloc/movie/movie_event.dart';
import 'package:multifilme/presentation/bloc/movie/movie_state.dart';
import '../mocks/movie_repository_mock.mocks.dart';

void main() {
  late MockMovieRepository mockRepository;
  late MovieBloc movieBloc;

  setUp(() {
    mockRepository = MockMovieRepository();
    movieBloc = MovieBloc(mockRepository);
  });

  tearDown(() {
    movieBloc.close();
  });

  test('Deve emitir [MovieLoading, MovieLoaded] quando FetchPopularMovies for chamado', () async {
    when(mockRepository.getPopularMovies(1)).thenAnswer((_) async => []);

    expectLater(
      movieBloc.stream,
      emitsInOrder([
        isA<MovieLoading>(),
        isA<MovieLoaded>(),
      ]),
    );

    movieBloc.add(FetchPopularMovies(1));
  });

  test('Deve emitir [MovieLoading, MovieError] quando a API falhar', () async {
    when(mockRepository.getPopularMovies(1)).thenThrow(Exception("Erro na API"));

    expectLater(
      movieBloc.stream,
      emitsInOrder([
        isA<MovieLoading>(),
        isA<MovieError>(),
      ]),
    );

    movieBloc.add(FetchPopularMovies(1));
  });
}
