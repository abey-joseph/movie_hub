//import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_hub/res/app_bar_pattern.dart';
import 'package:movie_hub/res/cat_heading_text.dart';
import 'package:movie_hub/res/colors.dart';
import 'package:movie_hub/tiles/cat_movie_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: Icon(
                    Icons.search,
                    size: 35,
                    color: Colors.black,
                  ),
                )
              ],
              backgroundColor: Colors.white,
              //shadowColor: Colors.transparent,
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.account_circle,
                  size: 35,
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
                      child: CustomPaint(
                        painter: WaveStripPainter(
                            greenLighter: Colors.white,
                            greenLight: AppColors.greenPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CatHeadText(
              text: "Top Trending",
            ),
            CatMovieList(),
            const CatHeadText(
              text: "Up Comming",
            ),
            CatMovieList(),
            const CatHeadText(
              text: "For You",
            ),
            CatMovieList(),
            const CatHeadText(
              text: "Top Rated",
            ),
            CatMovieList(),
          ],
        ),
      ),
    );
  }
}
