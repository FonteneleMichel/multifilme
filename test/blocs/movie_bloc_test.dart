import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multifilme/main.dart';
import 'package:multifilme/presentation/bloc/movie/movie_bloc.dart';
import 'package:multifilme/presentation/bloc/movie/movie_event.dart';
import 'package:multifilme/core/localization/language_provider.dart';
import 'package:provider/provider.dart';

import '../mocks/movie_repository_mock.mocks.dart';

void main() {
  late MockMovieRepository mockRepository;
  const String language = "pt-BR";

  setUp(() {
    mockRepository = MockMovieRepository();
  });

  testWidgets('Deve carregar a tela principal corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
          BlocProvider(
            create: (context) => MovieBloc(mockRepository)
              ..add(FetchPopularMovies(language)),
          ),
        ],
        child: MaterialApp(
          home: MyApp(repository: mockRepository),
        ),
      ),
    );

    expect(find.byType(MyApp), findsOneWidget);
  });
}
