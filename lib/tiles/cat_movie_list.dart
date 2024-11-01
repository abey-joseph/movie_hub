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

    // for (var movie in movieList) {
    //   print("ID: ${movie['id']}");
    //   print("Title: ${movie['title']}");
    //   print("Poster Path: ${movie['posterPath']}");
    //   print("Backdrop Path: ${movie['backdropPath']}");
    //   print('---------------------'); // Separator for each movie
    // }

    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 234,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieList.length,
              itemBuilder: (context, index) {
                return Hero(
                  tag: "$tag$index", // Unique tag based on the movie ID
                  child: MovieTile(
                    tag: "$tag$index",
                    movie: Movie(
                      movieList[index]['title'],
                      movieList[index]['posterPath'],
                      movieList[index]['backdropPath'],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
