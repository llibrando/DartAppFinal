import 'package:flutter/material.dart';
import 'screen_one.dart';
import 'calcugrades.dart'; // Import the Calcugrades screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Dart Applications',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to ScreenOne using Navigator.push
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScreenOne()),
                );
              },
              child: const Text('Clicker'),
            ),
            const SizedBox(height: 20), // Add some spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to Calcugrades using Navigator.push
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalcugradesApp()),
                );
              },
              child: const Text('Calcugrades'), // Updated button text
            ),
          ],
        ),
      ),
    );
  }
}