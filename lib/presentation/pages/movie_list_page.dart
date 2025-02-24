import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:multifilme/presentation/bloc/movie/movie_bloc.dart';
import 'package:multifilme/presentation/bloc/movie/movie_state.dart';
import 'package:multifilme/presentation/bloc/rated/top_rated_bloc.dart';
import 'package:multifilme/presentation/bloc/rated/top_rated_state.dart';
import '../../core/localization/app_localizations.dart';
import '../widgets/language_selector.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: LanguageSelector(),
          ),

          // 🔥 Carrossel usando o novo Bloc
          BlocBuilder<TopRatedBloc, TopRatedState>(
            builder: (context, state) {
              if (state is TopRatedLoaded) {
                return Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.5,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: state.movies.map((movie) {
                        return Builder(
                          builder: (context) {
                            return Container(
                              width: 189,
                              height: 276,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),

                    // 🔥 Indicadores do carrossel
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(state.movies.length, (index) {
                        return Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index ? Colors.red : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ],
                );
              } else if (state is TopRatedError) {
                return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),

          // 🔥 Lista de filmes usando o MovieBloc
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  return ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];
                      return ListTile(
                        leading: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                        title: Text(movie.title, style: Theme.of(context).textTheme.bodyLarge),
                        subtitle: Text(movie.releaseDate ?? '', style: Theme.of(context).textTheme.bodyMedium),
                      );
                    },
                  );
                } else if (state is MovieError) {
                  return Center(child: Text(state.message, style: const TextStyle(color: Colors.white)));
                }
                return const Center(child: Text("Nenhum filme encontrado", style: TextStyle(color: Colors.white)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
