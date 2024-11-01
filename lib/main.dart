import 'package:flutter/material.dart';
//import 'package:movie_hub/res/colors.dart';
import 'package:movie_hub/screens/splash_screen.dart';

void main() {
  runApp(const MovieHub());
}

class MovieHub extends StatelessWidget {
  const MovieHub({super.key});

  //const MovieHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: const SplashScreen(),
    );
  }
}
