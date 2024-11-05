import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatelessWidget {
  final double rating; // Rating out of 10

  const Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 164,
      child: Padding(
        padding: const EdgeInsets.only(top: 11, left: 10),
        child: RatingBarIndicator(
          rating: rating / 2,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
            size: 4,
          ),
          itemCount: 5,
          itemSize: 18,
          direction: Axis.horizontal,
        ),
      ),
    );
  }
}
