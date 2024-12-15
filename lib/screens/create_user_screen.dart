import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_hub/res/app_bar_pattern.dart';
import 'package:movie_hub/res/colors.dart';
import 'package:movie_hub/screens/homepage.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final Color lightGreen = const Color(0xFFA8E6CF);
  // Light green
  final Color lightYellow = const Color(0xFFFFF9C4);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> signUp() async {
    try {
      // Create user with Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Get the user ID (UID)
      String uid = userCredential.user!.uid;

      // Save additional user details in Firestore
      await _firestore.collection('users').doc(uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Navigate to HomePage
      if (!mounted) return;

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage())); // Navigate to HomePage
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = "This email is already in use.";
            break;
          case 'weak-password':
            errorMessage = "The password is too weak.";
            break;
          case 'invalid-email':
            errorMessage = "The email address is invalid.";
            break;
          default:
            errorMessage = "An unknown error occurred.";
        }
      } else {
        errorMessage = e.toString();
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AnimatedLock(),
                        const SizedBox(height: 16.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ListView(
                      children: [
                        const SizedBox(height: 10.0),

                        //Name
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: const Icon(Icons.face,
                                color: AppColors.greenPrimary),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightGreen),
                            ),
                          ),
                          obscureText: true,
                        ),

                        const SizedBox(height: 20.0),

                        //phone Number
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: const Icon(Icons.phone,
                                color: AppColors.greenPrimary),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightGreen),
                            ),
                          ),
                          obscureText: true,
                        ),

                        const SizedBox(height: 20.0),

                        // Email TextField
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email,
                                color: AppColors.greenPrimary),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightGreen),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // Password TextField
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock,
                                color: AppColors.greenPrimary),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: lightGreen),
                            ),
                          ),
                          obscureText: true,
                        ),

                        const SizedBox(height: 32.0),
                        // Login Button
                        ElevatedButton(
                          onPressed: () {
                            // Handle Sign Up logic
                            signUp();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.greenPrimary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80.0, vertical: 16.0),
                            textStyle: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                        const SizedBox(height: 16.0),

                        //button to test firestore connection

                        // ElevatedButton(
                        //   onPressed: () async {
                        //     try {
                        //       CollectionReference test =
                        //           FirebaseFirestore.instance.collection('test');
                        //       await test.add({'test': 'connection successful'});
                        //       print('Firestore connection successful!');
                        //     } catch (e) {
                        //       print('Error: $e');
                        //     }
                        //   },
                        //   child: Text("Test Firestore Connection"),
                        // )

                        // Forgot Password
                        // TextButton(
                        //   onPressed: () {
                        //     // Navigate to forgot password screen
                        //   },
                        //   child: Text(
                        //     'Forgot Password?',
                        //     style: TextStyle(color: Colors.grey[600]),
                        //   ),
                        // ),
                        // TextButton(
                        //   onPressed: () {
                        //     // Navigate to forgot password screen
                        //   },
                        //   child: Text(
                        //     'Create a New Account?',
                        //     style: TextStyle(color: Colors.grey[600]),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -207,
            child: SizedBox(
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
  const AnimatedLock({super.key});

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
      duration: const Duration(seconds: 4),
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

  const CustomLock({super.key, required this.color, required this.size});

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
