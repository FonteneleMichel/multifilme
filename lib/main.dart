import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'data/datasources/remote/api_service.dart';
import 'data/repositories/movie_repository.dart';
import 'core/network/dio_client.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/language_provider.dart';
import 'core/theme/theme.dart';
import 'presentation/bloc/movie/movie_bloc.dart';
import 'presentation/bloc/movie/movie_event.dart' as movie_events;
import 'presentation/bloc/rated/top_rated_bloc.dart';
import 'presentation/bloc/rated/top_rated_event.dart' as rated_events;
import 'presentation/pages/movie_detail_page.dart';
import 'presentation/pages/movie_list_page.dart';
import 'presentation/widgets/background_container.dart';

void main() {
  final dio = DioClient.createDio();
  final apiService = ApiService(dio);
  final repository = MovieRepository(apiService);

  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(repository: repository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final MovieRepository repository;

  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<MovieRepository>(
      create: (_) => repository,
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => MovieBloc(repository)..add(movie_events.FetchPopularMovies(1)),
              ),
              BlocProvider(
                create: (_) => TopRatedBloc(repository)..add(rated_events.FetchTopRatedMovies()),
              ),
            ],
            child: MaterialApp(
              title: 'Filmes Populares',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.theme,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('pt', 'BR'),
              ],
              locale: languageProvider.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              initialRoute: '/',
              routes: {
                '/': (context) => const BackgroundContainer(child: MovieListPage()),
                '/movieDetail': (context) => const MovieDetailPage(),
              },
            ),
          );
        },
      ),
    );
  }
}

