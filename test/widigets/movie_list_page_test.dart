import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:multifilme/presentation/bloc/movie_bloc.dart';
import 'package:multifilme/presentation/bloc/movie_event.dart';
import 'package:multifilme/presentation/bloc/movie_state.dart';
import 'package:multifilme/presentation/pages/movie_list_page.dart';
import '../mocks/movie_repository_mock.mocks.dart';

void main() {
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
  });

  testWidgets('Deve exibir o CircularProgressIndicator ao carregar', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => MovieBloc(mockRepository)..add(FetchPopularMovies(1)),
          child: MovieListPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Deve exibir uma lista de filmes quando carregado', (WidgetTester tester) async {
    when(mockRepository.getPopularMovies(1)).thenAnswer((_) async => []);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => MovieBloc(mockRepository)..add(FetchPopularMovies(1)),
          child: MovieListPage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Deve exibir uma mensagem de erro se a API falhar', (WidgetTester tester) async {
    when(mockRepository.getPopularMovies(1)).thenThrow(Exception("Erro na API"));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => MovieBloc(mockRepository)..add(FetchPopularMovies(1)),
          child: MovieListPage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text("Erro ao carregar filmes: Exception: Erro na API"), findsOneWidget);
  });
}
