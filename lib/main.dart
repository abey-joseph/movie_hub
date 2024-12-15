import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_hub/firebase_options.dart';
//import 'package:movie_hub/res/colors.dart';
import 'package:movie_hub/screens/splash_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
