import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:multifilme/main.dart';
import 'package:multifilme/presentation/bloc/movie_bloc.dart';
import 'mocks/movie_repository_mock.mocks.dart';

void main() {
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
  });

  testWidgets('Deve carregar a tela principal', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => MovieBloc(mockRepository),
        child: MaterialApp(
          home: MyApp(repository: mockRepository), // ✅ Passando o Mock aqui
        ),
      ),
    );

    // Verifica se a tela inicial do app é carregada
    expect(find.byType(MyApp), findsOneWidget);
  });
}
