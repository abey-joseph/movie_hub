//import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:movie_hub/functions/tmdb_functions.dart';
import 'package:movie_hub/res/movie_detail_class.dart';
import 'package:movie_hub/tiles/movie_tile.dart';

class CatMovieList extends StatelessWidget {
  final String tag;
  final List movieList;
  const CatMovieList({super.key, required this.tag, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 234,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Hero(
                  tag: "$tag$index", // Unique tag
                  child: MovieTile(
                    tag: "$tag$index",
                    movie: Movie(
                      id: movieList[index]['id'],
                      title: movieList[index]['title'],
                      poster: movieList[index]['posterPath'],
                      backDrop: movieList[index]['backdropPath'],
                      overView: movieList[index]["overview"],
                      year: movieList[index]["release_date"],
                      rating: movieList[index]["vote_average"],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
