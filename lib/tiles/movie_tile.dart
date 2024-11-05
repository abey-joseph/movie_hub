import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_hub/functions/cache_manager.dart';
import 'package:movie_hub/res/movie_detail_class.dart';
import 'package:movie_hub/screens/movie_detail.dart';
//import 'package:movie_hub/res/colors.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;
  final String tag;
  const MovieTile({super.key, required this.movie, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MovieDetailPage(
            movie: movie,
            tag: tag,
          );
        }));
      },
      child: ImageCard(movieLink: movie.poster),
    );
  }
}

class MovieTileInDetail extends StatelessWidget {
  final String imageUrl;

  const MovieTileInDetail({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ImageCard(movieLink: imageUrl);
  }
}

class MovieTileInSearch extends StatelessWidget {
  final Movie movie;
  final String tag;
  const MovieTileInSearch({super.key, required this.movie, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MovieDetailPage(
            movie: movie,
            tag: tag,
          );
        }));
      },
      child: ImageCard(movieLink: movie.poster),
    );
  }
}

//Card back ground

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.movieLink,
  });

  final String movieLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 220,
      margin: const EdgeInsets.all(7.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: movieLink.isNotEmpty
              ? ImageLoader(movieLink)
              : _buildFallbackWidget(),
        ),
      ),
    );
  }
}

//widget to download image and show image and to manage cache

CachedNetworkImage ImageLoader(String poster) {
  return CachedNetworkImage(
    imageUrl: poster,
    cacheManager: CustomCacheManager.instance,
    fit: BoxFit.cover,
    placeholder: (context, url) => Container(color: Colors.grey[300]),
    fadeInDuration: const Duration(milliseconds: 500),
    errorWidget: (context, error, stackTrace) {
      // Display a placeholder widget if the image fails to load
      return _buildFallbackWidget();
    },
  );
}

// for error situations

Widget _buildFallbackWidget() {
  return Container(
    color: Colors.grey[300],
    child: const Center(
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
