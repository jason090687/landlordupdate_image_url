import 'package:flutter/material.dart';
import 'package:tanle/starting_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                text: "CDO",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: "seek",
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFFfdcd25),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Discover your ideal boarding haven with\nCDOseek - your shortcut to comfortable living!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyStart()),
                );
              },
              // Replace with navigation code later
              child: const Text(
                "Find your Haven",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
                minimumSize: const Size(200.0, 60.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
