import 'package:flutter/material.dart';
import 'package:todo_app/page/note_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cochin',
        
        appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.black,
            
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Efimah',
                fontWeight: FontWeight.bold)),
        primaryColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/img/splash.png'),
      duration: 500,
      splashIconSize: 200,
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: const Duration(milliseconds: 1500),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      pageTransitionType: PageTransitionType.fade,
      nextScreen: const NotesPage(),
    );
  }
}
