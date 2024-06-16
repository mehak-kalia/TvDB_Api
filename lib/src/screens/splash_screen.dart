import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    fetchTokenAndNavigate();
  }

  Future<void> fetchTokenAndNavigate() async {
    try {
      // Fetch token
      final token = await fetchToken();
      setState(() {
        this.token = token;
      });

      // Simulate a delay to show the splash screen
      await Future.delayed(Duration(seconds: 2));

      // Navigate to HomeScreen once delay is complete
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen(token: token)),
      );
    } catch (e) {
      print('Error fetching token: $e');
      // Handle error (e.g., show error message, retry logic, etc.)
    }
  }

  Future<String> fetchToken() async {
    const String apiKey = '12e70dcf-0c55-4542-afe4-143b402a0424';
    const String baseUrl = 'https://api4.thetvdb.com/v4';
    final loginUrl = Uri.parse('$baseUrl/login');
    final body = jsonEncode({'apikey': apiKey});

    final response = await http.post(
      loginUrl,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['data']['token'];
      return token;
    } else {
      throw Exception('Failed to login and get token: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSunkeHD1rAk-AGdfeWjScckWze-z8gMXjWbQ&s',
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.green),
          ],
        ),
      ),
    );
  }
}
