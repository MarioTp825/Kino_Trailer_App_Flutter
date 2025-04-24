import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_movie_detail/domain/model/movie_ui.dart';
import 'package:my_movie_detail/presenter/ui/style/movie_theme.dart';
import 'package:my_movie_detail/presenter/utils/native_bridge.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieInfo extends StatefulWidget {
  final MovieUI movie;
  final String? author;

  const MovieInfo({super.key, required this.movie, this.author});

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  MovieUI get movieUI => widget.movie;
  bool _favorite = false;

  @override
  void initState() {
    super.initState();
    _favorite = widget.movie.favorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: context.themeColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(context),
          const SizedBox(height: 8),
          Expanded(child: buildMovieDetails(context)),
          buildBottomButtons(context),
        ],
      ),
    );
  }

  Row buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
              widget.movie.title!, style: context.themeFonts.titleLarge),
        ),
        IconButton(onPressed: _manageFavorite, icon: Icon(
            _favorite ? Icons.bookmark : Icons.bookmark_border
        )),
      ],
    );
  }

  void _manageFavorite() {
    final json = jsonEncode(movieUI.toJson());
    if (_favorite) {
      NativeBridge.instance.sendData("deleteMovieDetail", json);
    } else {
      NativeBridge.instance.sendData("storeMovieDetail", json);
    }

    setState(() {
      _favorite = !_favorite;
    });
  }

  Wrap buildMovieDetails(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      direction: Axis.horizontal,
      children: [
        _buildMovieEntry(
          context,
          Icons.movie_outlined,
          "Category",
          widget.movie.category,
        ),
        _buildMovieEntry(
          context,
          Icons.remove_red_eye_outlined,
          "Views",
          widget.movie.views?.toString(),
        ),
        if (widget.author != null)
          _buildMovieEntry(
              context, Icons.person_outline, "Author", widget.author),
      ],
    );
  }

  Row buildBottomButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              context.themeColors.primary,
            ),
          ),
          onPressed: _launchMovie,
          child: Text(
            "More Info",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(context.themeColors.error),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _launchMovie() {
    final rawUrl = widget.movie.websiteUrl;
    if (rawUrl == null) return;
    final url = Uri.parse(rawUrl);
    launchUrl(url);
  }

  Widget _buildMovieEntry(BuildContext context,
      IconData? icon,
      String title,
      String? value,) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Icon(icon, color: context.themeColors.primary, size: 20),
        const SizedBox(width: 5),
        Text(
          title,
          style: context.themeFonts.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Text(value ?? 'N/A', style: context.themeFonts.bodyMedium),
      ],
    );
  }
}
