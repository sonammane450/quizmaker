// import the material package
import 'package:flutter/material.dart';

import './screens/welcome_screen.dart'; // the welcome screen

// run the main method
void main() {
  // the runAPp method
  runApp(
    const MyApp(), // we will create this below
  );
}

// create the MyApp widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // remove the debug banner
      debugShowCheckedModeBanner: false,
      // set a homepage
      home: WelcomeScreen(), // start with welcome screen
    );
  }
}
