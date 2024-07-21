import 'package:flutter/material.dart';
import 'close_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  
  static const List<String> developerNames = [
    'Alejandro Tejeira',
    'Ryan Rahbari',
    'Benjamin Monroy',
    'Gabriel Rechdan',
    'Eugenio Diaz',
    'Joshua Bartz',
    'Joshua Jarquin',
  ];

  static const List<String> developerResponsibilities = [
    'Frontend',
    'Project Manager',
    'Mobile',
    'Frontend',
    'API',
    'Database & Frontend',
    'Mobile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenAppBar(title: 'About Us'),
      backgroundColor: Colors.grey[300], // Page background color similar to Armory page
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: developerNames.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75, // Aspect ratio to allow space for text
          ),
          itemBuilder: (context, index) {
            return Card(
              color: Colors.black, // Card color matching Armory page
              elevation: 4.0, // Card shadow
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Inner padding for card
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80.0), // Rounded corners
                      child: Image.asset(
                        'assets/about_us/image${index + 1}.png', // Ensure paths match your asset structure
                        fit: BoxFit.cover,
                        height: 140.0,
                        width: 140.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      developerNames[index], // Developer name
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color matching Armory page
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      developerResponsibilities[index], // Developer responsibility
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[400], // Secondary text color
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
