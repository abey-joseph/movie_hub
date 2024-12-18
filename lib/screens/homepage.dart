//import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_hub/functions/tmdb_functions.dart';
import 'package:movie_hub/res/app_bar_pattern.dart';
import 'package:movie_hub/res/cat_heading_text.dart';
import 'package:movie_hub/res/colors.dart';
import 'package:movie_hub/screens/login_screen.dart';
import 'package:movie_hub/screens/search_screens.dart';
import 'package:movie_hub/tiles/cat_movie_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logout() async {
    try {
      await _auth.signOut();

      // Navigate the user back to the login screen
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error signing out: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieService = MovieService();

    return FutureBuilder(
      future: movieService.fetchAllMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading movies'));
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            //extendBodyBehindAppBar: true,
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    AppColors.yellowLight
                  ], // Specify the colors for your gradient
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: IconButton(
                          icon: const Icon(Icons.search,
                              size: 35, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const SearchScreen();
                            }));
                          },
                        ),
                      )
                    ],
                    //forceMaterialTransparency: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    surfaceTintColor: Colors.transparent,
                    //shadowColor: Colors.transparent,
                    leading: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: IconButton(
                        onPressed: () {
                          logout();
                        },
                        icon: Icon(Icons.account_circle),
                        color: Colors.black,
                      ),
                    ),
                    pinned: true,
                    collapsedHeight: 110,
                    expandedHeight: 220,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        "M O V I E  H U B",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green[900])),
                      ),
                      centerTitle: false,
                      titlePadding: const EdgeInsets.only(left: 30, bottom: 16),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned.fill(
                            child: Hero(
                              tag: "a",
                              child: CustomPaint(
                                painter: WaveStripPainter(
                                    greenLighter: Colors.white,
                                    greenLight: AppColors.greenPrimary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const CatHeadText(
                    text: "Top Trending",
                  ),
                  CatMovieList(
                    tag: '1',
                    movieList: movieService.topTrendingList,
                  ),
                  const CatHeadText(
                    text: "For You",
                  ),
                  CatMovieList(
                    tag: '2',
                    movieList: movieService.forYouList,
                  ),
                  const CatHeadText(
                    text: "Popular",
                  ),
                  CatMovieList(
                    tag: '3',
                    movieList: movieService.popularList,
                  ),
                  const CatHeadText(
                    text: "Top Rated",
                  ),
                  CatMovieList(
                    tag: '4',
                    movieList: movieService.topRatedList,
                  ),
                  const CatHeadText(
                    text: "Up Comming",
                  ),
                  CatMovieList(
                    tag: '5',
                    movieList: movieService.upComingList,
                  ),
                  const CatHeadText(
                    text: "Now Playing",
                  ),
                  CatMovieList(
                    tag: '6',
                    movieList: movieService.nowPlayingList,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
