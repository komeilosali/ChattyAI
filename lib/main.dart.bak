import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chatgpt/MainScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChattyAI',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: AnimatedSplashScreen(
        splash: Container(
          width: 50,
          height: 50,
          child: SingleChildScrollView(
            // Wrap the Column with SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/IC_Indigo_BG_White_RB.jpg'),
                const SizedBox(height: 16.0),
                Text(
                  'ChattyAI',
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        duration: 1500,
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.fade,
        animationDuration: Duration(milliseconds: 2000),
        backgroundColor: Colors.indigo,
        nextScreen: Main_Screen(),
      ),
    );
  }
}
