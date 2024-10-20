//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_hub/tiles/movie_tile.dart';

class CatMovieList extends StatelessWidget {
  const CatMovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                MovieTile(
                  imageUrl:
                      "https://media.themoviedb.org/t/p/w220_and_h330_face/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
                ),
                MovieTile(
                  imageUrl:
                      "https://media.themoviedb.org/t/p/w220_and_h330_face/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
                ),
                MovieTile(
                  imageUrl:
                      "https://media.themoviedb.org/t/p/w220_and_h330_face/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
                ),
                MovieTile(
                  imageUrl:
                      "https://media.themoviedb.org/t/p/w220_and_h330_face/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
                ),
                MovieTile(
                  imageUrl:
                      "https://media.themoviedb.org/t/p/w220_and_h330_face/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
                ),
                MovieTile(
                  imageUrl:
                      "https://media.themoviedb.org/t/p/w220_and_h330_face/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
                ),
                MovieTile(
                  imageUrl:
                      "https://media.themoviedb.org/t/p/w220_and_h330_face/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
                ),
                MovieTile(
                  imageUrl:
                      "https://media.themoviedb.org/t/p/w220_and_h330_face/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
