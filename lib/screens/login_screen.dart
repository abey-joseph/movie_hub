import 'package:flutter/material.dart';
import 'package:movie_hub/res/app_bar_pattern.dart';
import 'package:movie_hub/res/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 300,
            width: double.maxFinite,
            //color: Colors.red,
            child: CustomPaint(
              painter: WaveStripPainter(
                  greenLighter: Colors.white,
                  greenLight: AppColors.greenPrimary),
            ),
          ),
          Center(
              child: Column(
            children: [],
          ))
        ],
      ),
    );
  }
}
