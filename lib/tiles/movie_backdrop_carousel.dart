// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_hub/functions/cache_manager.dart';
import 'package:movie_hub/screens/large_image_screen.dart';
//import 'package:movie_hub/screens/movie_detail.dart';

class MovieBackdropCarousel extends StatelessWidget {
  final List<String> backdrops;

  const MovieBackdropCarousel({super.key, required this.backdrops});

  @override
  Widget build(BuildContext context) {
    return backdrops.isNotEmpty
        ? CarouselSlider(
            options: CarouselOptions(
              height: 230,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
            ),
            items: backdrops.map((backdropUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return LargeImageScreen(imageUrl: backdropUrl);
                      }));
                    },
                    child: CachedNetworkImage(
                      imageUrl: backdropUrl,
                      cacheManager: CustomCacheManager.instance,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) {
                        return _buildFallbackWidget();
                      },
                    ),
                  );
                },
              );
            }).toList(),
          )
        : _buildFallbackWidget();
  }
}

class BackdropInLargeScreen extends StatelessWidget {
  final String imageUrl;
  const BackdropInLargeScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheManager: CustomCacheManager.instance,
      fit: BoxFit.cover,
      errorWidget: (context, error, stackTrace) {
        return _buildFallbackWidget();
      },
    );
  }
}

Widget _buildFallbackWidget() {
  return Container(
    height: 230,
    color: Colors.grey[300],
    child: Center(
      child: Text(
        'Image not available',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
