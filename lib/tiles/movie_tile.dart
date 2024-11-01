import 'package:flutter/material.dart';
import 'package:movie_hub/res/movie_detail_class.dart';
import 'package:movie_hub/screens/movie_detail.dart';
//import 'package:movie_hub/res/colors.dart';

class MovieTile extends StatelessWidget {
  //final String imageUrl;
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
      child: Container(
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
            child: Image.network(
              movie.poster,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MovieTileInDetail extends StatelessWidget {
  final String imageUrl;

  const MovieTileInDetail({super.key, required this.imageUrl});

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
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
