import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_hub/functions/tmdb_functions.dart';
import 'package:movie_hub/res/colors.dart';
import 'package:movie_hub/screens/homepage.dart';
import 'package:movie_hub/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool login = false;

  @override
  void initState() {
    super.initState();
    final movieService = MovieService();
    movieService.fetchAllMovies();
    checkLogin(); // Call checkLogin in initState
  }

  // No need to pass context explicitly, use mounted to check if widget is still active.
  checkLogin() async {
    await Future.delayed(const Duration(seconds: 1));

    // Ensure the widget is still in the tree before proceeding
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null) {
      // User is logged in
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // User is not logged in
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.greenLight,
      body: Center(
        child:
            CircularProgressIndicator(), // Optional: Show a loading indicator
      ),
    );
  }
}
