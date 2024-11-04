//import 'package:flutter/material.dart';

class Movie {
  final int id;
  final String title;
  final String poster;
  final String backDrop;
  final String overView;
  final String year;
  final double rating;

  Movie(
      {required this.id,
      required this.title,
      required this.poster,
      required this.backDrop,
      required this.overView,
      required this.year,
      required this.rating});
}
