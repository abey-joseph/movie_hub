//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_hub/functions/tmdb_functions.dart';
import 'package:movie_hub/res/movie_detail_class.dart';
import 'package:movie_hub/tiles/movie_tile.dart';

class CatMovieList extends StatelessWidget {
  final String tag;
  final List movieList;
  const CatMovieList({super.key, required this.tag, required this.movieList});

  @override
  Widget build(BuildContext context) {
    final movieService = MovieService();

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Hero(
                tag: tag,
                child: MovieTile(
                  movie: Movie(movieList[0]['title'],
                      movieList[0]['posterPath'], movieList[0]['backdropPath']),
                ),
              ),
              MovieTile(
                movie: Movie(movieList[1]['title'], movieList[1]['posterPath'],
                    movieList[1]['backdropPath']),
              ),
              MovieTile(
                movie: Movie(movieList[2]['title'], movieList[2]['posterPath'],
                    movieList[2]['backdropPath']),
              ),
              MovieTile(
                movie: Movie(movieList[3]['title'], movieList[3]['posterPath'],
                    movieList[3]['backdropPath']),
              ),
              MovieTile(
                movie: Movie(movieList[4]['title'], movieList[4]['posterPath'],
                    movieList[4]['backdropPath']),
              ),
              MovieTile(
                movie: Movie(movieList[5]['title'], movieList[5]['posterPath'],
                    movieList[5]['backdropPath']),
              ),
              MovieTile(
                movie: Movie(movieList[6]['title'], movieList[6]['posterPath'],
                    movieList[6]['backdropPath']),
              ),
              MovieTile(
                movie: Movie(movieList[7]['title'], movieList[7]['posterPath'],
                    movieList[7]['backdropPath']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
