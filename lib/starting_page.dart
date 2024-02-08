import 'package:flutter/material.dart';
import 'package:tanle/components/insert_tile.dart';
import 'package:tanle/pages/login_or_register.dart';

class MyStart extends StatelessWidget {
  const MyStart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Reduced size temporary image circle
                Container(
                  width: 210.0,
                  height: 210.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/Ellipse 4.png'), // Replace with your image path
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                // Reduced size image circles
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/Ellipse 5.png'), // Replace with your image path
                        ),
                      ),
                    ),
                    Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/Ellipse 6.png'), // Replace with your image path
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                // Title text with increased font size and custom coloring
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'CDO',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'seek',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                // Description text without bold styling
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome to Teambangan\'s Boarding House Finder – your shortcut to the perfect home away from home, where comfort and community converge with just a tap!',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Larger and wider Start exploring button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginOrRegister()),
                    );
                  },
                  label: const Text('User Interface'),
                  icon: const Icon(Icons.arrow_upward_sharp),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70.0, vertical: 10.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Larger and wider Landlord Interface button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyInsertTile()),
                    );
                  },
                  icon: const Icon(Icons.arrow_upward),
                  label: const Text('Landlord Interface'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60.0, vertical: 10.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
