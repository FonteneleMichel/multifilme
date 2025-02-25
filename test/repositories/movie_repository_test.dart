import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:multifilme/data/repositories/movie_repository.dart';
import '../mocks/movie_repository_mock.mocks.dart';

void main() {
  late MockMovieRepository mockRepository;
  const String language = "pt-BR";
  const int page = 1;

  setUp(() {
    mockRepository = MockMovieRepository();
  });

  test('Deve retornar uma lista de filmes quando chamado corretamente', () async {
    when(mockRepository.getPopularMovies(language, page)).thenAnswer((_) async => []);

    final result = await mockRepository.getPopularMovies(language, page);

    expect(result, isA<List>());
    verify(mockRepository.getPopularMovies(language, page)).called(1);
  });

  test('Deve lançar uma exceção quando a API falhar', () async {
    when(mockRepository.getPopularMovies(language, page))
        .thenThrow(Exception("Erro na API"));

    expect(() => mockRepository.getPopularMovies(language, page),
        throwsA(isA<Exception>()));

    verify(mockRepository.getPopularMovies(language, page)).called(1);
  });
}
