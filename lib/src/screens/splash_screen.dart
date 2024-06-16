import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay to show the splash screen
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the HomeScreen once the delay is complete
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSunkeHD1rAk-AGdfeWjScckWze-z8gMXjWbQ&s'),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.green,),
          ],
        ),
      ),
    );
  }
}
