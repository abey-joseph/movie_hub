import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(top: 11),
        width: MediaQuery.of(context).size.width - 164,
        height: 30,
        child: Row(
          children: [
            Image.network(
                height: 30,
                width: 100,
                fit: BoxFit.cover,
                "https://static.vecteezy.com/system/resources/thumbnails/009/663/927/small/5-star-rating-review-star-transparent-free-png.png"),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
