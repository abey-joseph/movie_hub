import 'package:flutter/material.dart';
import 'package:movie_hub/tiles/movie_backdrop_carousel.dart';

class LargeImageScreen extends StatelessWidget {
  final String imageUrl;
  const LargeImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
          panEnabled: true,
          minScale: 1.0,
          maxScale: 4.0,
          child: Center(child: BackdropInLargeScreen(imageUrl: imageUrl))),
    );
  }
}
