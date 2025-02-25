import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:multifilme/presentation/bloc/movie/movie_bloc.dart';
import 'package:multifilme/presentation/bloc/movie/movie_event.dart';
import 'package:multifilme/presentation/bloc/movie/movie_state.dart';
import 'package:multifilme/domain/entities/movie.dart';
import '../mocks/movie_repository_mock.mocks.dart';

void main() {
  late MockMovieRepository mockRepository;
  late MovieBloc movieBloc;
  const String language = "pt-BR";
  const int page = 1;

  setUp(() {
    mockRepository = MockMovieRepository();
    movieBloc = MovieBloc(mockRepository);
  });

  tearDown(() {
    movieBloc.close();
  });

  test('Deve emitir [MovieLoading, MovieLoaded] quando FetchPopularMovies for chamado', () async {
    final mockMovies = [
      Movie(
        id: 1,
        title: "Filme 1",
        posterPath: "/path.jpg",
        voteAverage: 8.5,
        voteCount: 100,
        overview: "Descrição do filme",
      )
    ];

    when(mockRepository.getPopularMovies(language, page)).thenAnswer((_) async => mockMovies);

    expectLater(
      movieBloc.stream,
      emitsInOrder([
        isA<MovieLoading>(),
        isA<MovieLoaded>().having((state) => state.movies.isNotEmpty, 'Filmes carregados', true),
      ]),
    );

    movieBloc.add(FetchPopularMovies(language));
  });

  test('Deve emitir [MovieLoading, MovieError] quando a API falhar', () async {
    when(mockRepository.getPopularMovies(language, page)).thenThrow(Exception("Erro na API"));

    expectLater(
      movieBloc.stream,
      emitsInOrder([
        isA<MovieLoading>(),
        isA<MovieError>(),
      ]),
    );

    movieBloc.add(FetchPopularMovies(language));
  });
}
