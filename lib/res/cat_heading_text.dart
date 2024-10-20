import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CatHeadText extends StatelessWidget {
  final String text;
  const CatHeadText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 30, bottom: 16),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
