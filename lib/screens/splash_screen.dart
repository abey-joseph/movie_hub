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
    if (!mounted) return;

    //check if login or not - if login already then change the variable login to true and vice versa

    // Navigate to the HomePage after login is set to true or false

    if (login) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
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
