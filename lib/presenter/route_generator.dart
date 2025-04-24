import 'package:flutter/material.dart';
import 'package:my_movie_detail/domain/model/movie_ui.dart';
import 'package:my_movie_detail/presenter/ui/screens/error_screen.dart';
import 'package:my_movie_detail/presenter/ui/screens/me_info_screen.dart';
import 'package:my_movie_detail/presenter/ui/screens/movie_detail_screen.dart';
import 'package:my_movie_detail/presenter/ui/widgets/android_bridge.dart';
import 'package:my_movie_detail/presenter/ui/widgets/back_handler.dart';
import 'package:my_movie_detail/presenter/ui/widgets/movie_info.dart';

class RouteGenerator {
  static const String home = '/';
  static const String movieDetail = '/movie/detail';
  static const String tempMovieInfo = 'temp/movie/info';
  static const String meInfo = 'temp/me/info';
  static const String error = '/error/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const AndroidBridge());
      case movieDetail:
        final movie = args as MovieUI;
        return MaterialPageRoute(
          builder: (_) => BackHandler(child: MovieDetailScreen(movie: movie)),
        );
      case tempMovieInfo:
        final movie = args as MovieUI;
        return MaterialPageRoute(builder: (_) => BackHandler(child: MovieInfo(movie: movie)));
      case meInfo:
        return MaterialPageRoute(builder: (_) => BackHandler(child: const MeInfoScreen()));
      default:
        final msg = args?.toString();
        return MaterialPageRoute(
          builder:
              (_) => BackHandler(
                child: ErrorScreen(
                  message:
                      msg ??
                      "An unexpected error has occurred, please contact your provider.",
                ),
              ),
        );
    }
  }

}
