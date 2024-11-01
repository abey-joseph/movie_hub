import 'package:flutter/material.dart';

class LeftSideText extends StatelessWidget {
  final String text;
  const LeftSideText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
            width: MediaQuery.of(context).size.width - 164,
            child: Padding(
                padding: const EdgeInsets.only(top: 11, left: 10),
                child: Text(text))));
  }
}
