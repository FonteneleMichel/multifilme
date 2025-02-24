import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'data/datasources/remote/api_service.dart';
import 'data/repositories/movie_repository.dart';
import 'core/network/dio_client.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/language_provider.dart';
import 'presentation/bloc/movie_bloc.dart';
import 'presentation/bloc/movie_event.dart';
import 'presentation/pages/movie_list_page.dart';

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
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return BlocProvider(
          create: (_) => MovieBloc(repository)
            ..add(FetchPopularMovies(1))
            ..add(FetchTopRatedMovies()),
          child: MaterialApp(
            title: 'Filmes Populares',
            debugShowCheckedModeBanner: false,
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
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) return const Locale('en', 'US');
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              return const Locale('en', 'US');
            },
            home: const MovieListPage(),
          ),
        );
      },
    );
  }
}
