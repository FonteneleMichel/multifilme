import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:multifilme/presentation/bloc/rated/top_rated_bloc.dart';
import 'package:multifilme/presentation/bloc/rated/top_rated_state.dart';
import '../../core/localization/app_localizations.dart';
import '../bloc/movie/movie_bloc.dart';
import '../bloc/movie/movie_event.dart';
import '../bloc/movie/movie_state.dart';

import '../widgets/language_selector.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  int _currentIndex = 0;
  String _selectedCategory = "Nos Cinemas";

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
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/movieDetail',
                                  arguments: movie.id,
                                );
                              },
                              child: Container(
                                width: 189,
                                height: 276,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(state.movies.length, (index) {
                        return Container(
                          width: 4,
                          height: 10,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.purple
                                : Colors.white,
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🔥 Botão "Nos Cinemas"
                SizedBox(
                  width: 110,
                  height: 37,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = "Nos Cinemas";
                      });
                      context.read<MovieBloc>().add(FetchNowPlayingMovies());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, // 🔥 Remove o padding interno
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                      backgroundColor: Colors
                          .transparent, // 🔥 Transparente para usar gradiente no Container
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: _selectedCategory == "Nos Cinemas"
                            ? const LinearGradient(
                                colors: [Color(0xFF0E9FF3), Color(0xFF094B96)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null, // 🔥 Apenas o botão ativo recebe gradiente
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: double.infinity,
                        child: const Text(
                          "Nos Cinemas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 4), // 🔥 Espaçamento entre botões

                // 🔥 Botão "Em Breve"
                SizedBox(
                  width: 110,
                  height: 37,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = "Em Breve";
                      });
                      context.read<MovieBloc>().add(FetchUpcomingMovies());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero, // 🔥 Remove o padding interno
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                      backgroundColor: Colors
                          .transparent, // 🔥 Transparente para usar gradiente no Container
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: _selectedCategory == "Em Breve"
                            ? const LinearGradient(
                                colors: [Color(0xFF0E9FF3), Color(0xFF094B96)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null, // 🔥 Apenas o botão ativo recebe gradiente
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: double.infinity,
                        child: const Text(
                          "Em Breve",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 160 / 280,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/movieDetail',
                              arguments: movie.id,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  width: 160,
                                  height: 222,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const SizedBox(width: 4),
                                  Container(
                                    width: 31,
                                    height: 20,

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: Color(0xFFC60385),
                                          width: 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        movie.voteAverage.toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${movie.voteCount} votos",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const Center(
                    child: Text("Nenhum filme encontrado",
                        style: TextStyle(color: Colors.white)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
