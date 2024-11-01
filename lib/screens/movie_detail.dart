// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_hub/res/movie_detail_class.dart';
import 'package:movie_hub/tiles/left_side_text.dart';
import 'package:movie_hub/tiles/movie_tile.dart';
import 'package:movie_hub/tiles/rating.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Image.network(
                  height: 230,
                  movie.backDrop,
                  fit: BoxFit.cover,
                ),
              ),
              LeftSideText(
                text: 'Category',
              ),
              LeftSideText(text: "year"),
              LeftSideText(text: "Run Time"),
              Rating(),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                    "A listless Wade Wilson toils away in civilian life with his days as the morally flexible mercenary, Deadpool, behind him. But when his homeworld faces an existential threat, Wade must reluctantly suit-up again with an even more reluctant Wolverine."),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, bottom: 4),
                  child: Divider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column (Starring)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Starring',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text('Robert Downey Jr.'),
                          Text('Chris Evans'),
                          Text('Mark Ruffalo'),
                          Text('Chris Hemsworth'),
                          Text('Scarlett Johansson'),
                        ],
                      ),
                    ),
                  ),
                  // Vertical Divider
                  Container(
                    height: 150,
                    width: 2,
                    color: Colors.grey[300],
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  // Right Column (Directors, Producers, Screenwriters)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Director(s)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text('Joss Whedon'),
                          SizedBox(height: 16),
                          Text(
                            'Producer(s)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text('Kevin Feige'),
                          SizedBox(height: 16),
                          Text(
                            'Screenwriter(s)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text('Kevin Feige'),
                          SizedBox(height: 16),
                          // You can add more text widgets for screenwriters here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              top: 160,
              child: Hero(tag: "1", child: MovieTile(imageUrl: movie.poster)))
        ],
      )),
    );
  }
}
