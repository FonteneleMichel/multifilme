import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'data/datasources/remote/api_service.dart';
import 'core/network/dio_client.dart';
import 'core/network/api_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = DioClient.createDio();
  final apiService = ApiService(dio);

  final popularMovies = await apiService.getPopularMovies(
    ApiConfig.apiKey,
    ApiConfig.language,
    1, // Página 1
    "popularity.desc",
    false,
    false,
  );

  print(popularMovies.results.map((movie) => movie.title).toList()); // Verifica no console

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Verifique os logs do console!"),
        ),
      ),
    );
  }
}
