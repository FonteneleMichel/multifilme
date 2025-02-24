import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:multifilme/data/repositories/movie_repository.dart';
import '../mocks/movie_repository_mock.mocks.dart';

void main() {
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
  });

  test('Deve retornar uma lista de filmes quando chamado corretamente', () async {
    when(mockRepository.getPopularMovies(1)).thenAnswer((_) async => []);

    final result = await mockRepository.getPopularMovies(1);

    expect(result, isA<List>());
    verify(mockRepository.getPopularMovies(1)).called(1);
  });
}
