import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_movie_detail/domain/model/movie_ui.dart';
import 'package:my_movie_detail/presenter/ui/style/movie_theme.dart';
import 'package:my_movie_detail/presenter/ui/widgets/movie_info.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieUI movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late YoutubePlayerController _controller;
  String? author;

  MovieUI get movie => widget.movie;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: movie.youtubeId!,
      flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
        //Skip KinoCheck intro
        startAt: 3
      ),
    )..addListener(_listener);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trailer"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: context.themeColors.primary,
            onReady: () {
              setState(() {});
              SchedulerBinding.instance.scheduleFrame();
            },
          ),
          const SizedBox(height: 10),
          Expanded(child: MovieInfo(movie: movie, author: author)),
        ],
      ),
    );
  }

  void _listener() {
    if (!_controller.value.isFullScreen) {
      setState(() {
        author = _controller.metadata.author;
      });
    }
  }
}
