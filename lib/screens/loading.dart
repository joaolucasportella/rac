import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rac/main.dart';
import 'package:page_transition/page_transition.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
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
        child: const Center(
          child: Image(
              width: 300,
              height: 300,
              image: AssetImage('assets/anim/logo-loading.gif')),
        ),
      ),
      nextScreen: const MainPage(),
      duration: 1000,
      splashIconSize: 1000,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
