import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_hub/res/app_bar_pattern.dart';
import 'package:movie_hub/res/colors.dart';
import 'package:movie_hub/screens/homepage.dart';

class LoginScreen extends StatelessWidget {
  final Color lightGreen = Color(0xFFA8E6CF); // Light green
  final Color lightYellow = Color(0xFFFFF9C4); // Light yellow

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.greenLight,
                  Colors.white,
                  Colors.white,
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                // Animated top part
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedLock(),
                        SizedBox(height: 16.0),
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Login form
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: ListView(
                      children: [
                        SizedBox(height: 40.0),
                        // Email TextField
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email,
                                color: AppColors.greenPrimary),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightGreen),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        // Password TextField
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon:
                                Icon(Icons.lock, color: AppColors.greenPrimary),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightGreen),
                            ),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 32.0),
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            // Handle login logic
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage()));
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.greenPrimary,
                            padding: EdgeInsets.symmetric(
                                horizontal: 80.0, vertical: 16.0),
                            textStyle: TextStyle(fontSize: 18.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        // Forgot Password
                        TextButton(
                          onPressed: () {
                            // Navigate to forgot password screen
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to forgot password screen
                          },
                          child: Text(
                            'Create a New Account?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -207,
            child: Container(
              height: 300,
              child: Hero(
                tag: "a",
                child: CustomPaint(
                  painter: WaveStripPainter(
                      greenLighter: Colors.white,
                      greenLight: AppColors.greenPrimary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedLock extends StatefulWidget {
  @override
  _AnimatedLockState createState() => _AnimatedLockState();
}

class _AnimatedLockState extends State<AnimatedLock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<IconData> _iconAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _iconAnimation = TweenSequence<IconData>([
      TweenSequenceItem(
        tween: ConstantTween(Icons.lock),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ConstantTween(Icons.lock_open),
        weight: 50,
      ),
    ]).animate(_animation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _iconAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + 0.1 * sin(_controller.value * 2 * pi),
          child: Icon(
            _iconAnimation.value,
            size: 100,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class CustomLock extends StatelessWidget {
  final Color color;
  final double size;

  CustomLock({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: LockPainter(color),
    );
  }
}

class LockPainter extends CustomPainter {
  final Color color;

  LockPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // Draw the lock body
    final rect = Rect.fromLTWH(size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.4);
    canvas.drawRect(rect, paint);

    // Draw the lock shackle
    final shackleRect = Rect.fromLTWH(size.width * 0.35, size.height * 0.2,
        size.width * 0.3, size.height * 0.4);
    canvas.drawArc(shackleRect, -3.14, 3.14, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
