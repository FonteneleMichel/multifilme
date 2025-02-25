import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multifilme/core/localization/app_localizations.dart';
import 'package:multifilme/data/repositories/movie_repository.dart';
import 'package:multifilme/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:multifilme/presentation/bloc/detail/movie_detail_event.dart';
import 'package:multifilme/presentation/bloc/detail/movie_detail_state.dart';
import 'package:provider/provider.dart';
import 'package:multifilme/core/localization/language_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as int;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLanguage = languageProvider.locale.languageCode;
    final localizations = AppLocalizations.of(context);

    String _formatDate(String date) {
      try {
        DateTime parsedDate = DateTime.parse(date);
        return DateFormat("dd 'de' MMMM 'de' yyyy", currentLanguage).format(parsedDate);
      } catch (e) {
        return localizations!.translate("unknown_date");
      }
    }

    return BlocProvider(
      create: (context) => MovieDetailBloc(context.read<MovieRepository>())
        ..add(FetchMovieDetail(movieId, currentLanguage)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/image/background.jpg",
                fit: BoxFit.cover,
              ),
            ),

            BlocBuilder<MovieDetailBloc, MovieDetailState>(
              builder: (context, state) {
                if (state is MovieDetailLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieDetailLoaded) {
                  final movie = state.movie;
                  String videoId = movie.trailerKey ?? "";
                  bool hasTrailer = videoId.isNotEmpty && videoId.runtimeType == String;

                  return Column(
                    children: [
                      if (hasTrailer)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: videoId,
                              flags: const YoutubePlayerFlags(
                                autoPlay: false,
                                mute: false,
                              ),
                            ),
                            bottomActions: [],
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                            progressColors: const ProgressBarColors(
                              playedColor: Colors.red,
                              handleColor: Colors.redAccent,
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              localizations!.translate("trailer_not_available"),
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),

                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.black.withOpacity(0.0),
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                    bottom: 100,
                                  ),
                                  child: SingleChildScrollView(
                                    padding: const EdgeInsets.only(bottom: 72),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movie.title,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          movie.originalTitle,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(height: 12),

                                        Text(
                                          "${localizations!.translate("year")}: ${movie.releaseDate.split('-')[0]}",
                                          style: const TextStyle(color: Colors.white),
                                        ),

                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 20),
                                            const SizedBox(width: 6),
                                            Text(
                                              "${movie.voteAverage.toStringAsFixed(1)} • ${movie.voteCount} ${localizations.translate("votes")}",
                                              style: const TextStyle(color: Colors.white, fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),

                                        Text(
                                          "${localizations.translate("genres")}: ${movie.genres.join(', ')}",
                                          style: const TextStyle(color: Colors.white, fontSize: 16),
                                        ),
                                        const SizedBox(height: 12),

                                        Text(
                                          localizations.translate("summary"),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          movie.overview,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            height: 1.5,
                                          ),
                                        ),
                                        const SizedBox(height: 12),

                                        Text(
                                          "${localizations.translate("release_date")}: ${_formatDate(movie.releaseDate)}",
                                          style: const TextStyle(color: Colors.white, fontSize: 16),
                                        ),
                                        Text(
                                          "${localizations.translate("origin")}: ${movie.productionCountries.join(', ')}",
                                          style: const TextStyle(color: Colors.white, fontSize: 16),
                                        ),
                                        Text(
                                          "${localizations.translate("budget")}: \$${movie.budget?.toString() ?? localizations.translate("unknown_budget")}",
                                          style: const TextStyle(color: Colors.white, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 64,
                              left: 16,
                              right: 16,
                              child: SizedBox(
                                width: 343,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final url = Uri.parse("https://www.themoviedb.org/movie/${movie.id}");
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF0E9FF3), Color(0xFF094B96)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 400,
                                        minHeight: 52,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        localizations.translate("official_page"), // 🔥 Agora traduz corretamente
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: Text(
                    localizations!.translate("error_loading"),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
