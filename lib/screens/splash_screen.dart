import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rac/screens/sliders_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xFF5969c9),
              Color(0xFF3040a3),
            ])),
        child: const Image(image: AssetImage('assets/anim/logoanim.gif')),
      ),
      nextScreen: const SlidersScreen(),
      duration: 1000,
      splashIconSize: 1000,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
