// ignore_for_file: prefer_const_constructors

//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:movie_hub/functions/cache_manager.dart';
import 'package:movie_hub/functions/tmdb_functions.dart';
import 'package:movie_hub/res/adv_movie_detail_class.dart';
import 'package:movie_hub/res/movie_detail_class.dart';
import 'package:movie_hub/tiles/left_side_text.dart';
import 'package:movie_hub/tiles/movie_backdrop_carousel.dart';
import 'package:movie_hub/tiles/movie_tile.dart';
import 'package:movie_hub/tiles/rating.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie; // Use the existing Movie class to get the ID
  final String tag;

  MovieDetailPage({super.key, required this.movie, required this.tag});

  Future<AdvMovie> fetchDetailedMovieData() async {
    return await fetchAdvMovieDetails(
        movie.id); // Use movie.id to fetch details
  }

  List<String> backDrops = []; // List to store backdrop images

  // Function to fetch backdrops; this remains unchanged
  Future backDropList() async {
    backDrops = await fetchBackdropImages(movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<AdvMovie>(
          future: fetchDetailedMovieData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error'); // Handle error
            } else if (!snapshot.hasData) {
              return Text('No Data Available'); // Handle empty data
            }

            final advMovie = snapshot.data!;
            return Text(
              advMovie.title,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              )),
            );
          },
        ),
      ),
      body: FutureBuilder<AdvMovie>(
        future: fetchDetailedMovieData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading movie details'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          final advMovie = snapshot.data!;
          return SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      // Backdrop carousel FutureBuilder remains unchanged
                      child: FutureBuilder(
                        future: backDropList(),
                        builder: (context, snapshot) {
                          return MovieBackdropCarousel(backdrops: backDrops);
                        },
                      ),
                    ),
                    LeftSideText(
                      text: advMovie.category,
                    ),
                    LeftSideText(text: 'Year: ${advMovie.year}'),
                    LeftSideText(text: "Run Time: ${advMovie.runTime} min"),
                    Padding(
                      padding: const EdgeInsets.only(left: 160),
                      child: Rating(
                        rating: advMovie.rating,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(advMovie.overView),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 4),
                      child: Divider(),
                    ),
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
                              children: [
                                Text(
                                  'Starring',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                ...advMovie.starring
                                    .map((actor) => Text(actor)),
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
                              children: [
                                Text(
                                  'Director(s)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                ...advMovie.directors
                                    .map((director) => Text(director)),
                                SizedBox(height: 16),
                                Text(
                                  'Producer(s)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                ...advMovie.producers
                                    .map((producer) => Text(producer)),
                                SizedBox(height: 16),
                                Text(
                                  'Screenwriter(s)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                ...advMovie.writers
                                    .map((writer) => Text(writer)),
                                SizedBox(height: 16),
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
                    child: Hero(
                        tag: tag,
                        child: MovieTileInDetail(imageUrl: advMovie.poster)))
              ],
            ),
          );
        },
      ),
    );
  }
}
