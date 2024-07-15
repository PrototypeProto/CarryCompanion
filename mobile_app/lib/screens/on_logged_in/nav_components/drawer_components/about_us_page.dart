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

  static const List<String> DeveloperResponsibilities = [
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
      backgroundColor: Colors.blue[200], // Page background color
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 7,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 images per row
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.64, // Adjust aspect ratio to allow space for text
          ),
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(255, 209, 172, 6), // Card color
              elevation: 4.0, // Card shadow
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Inner padding for card
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80.0), // Rounded corners
                      child: Image.asset(
                        'assets/about_us/image${index + 1}.png', // Ensure paths match your asset structure
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      developerNames[index], // Replace with your titles
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue, // First line text color
                      ),
                    ),
                    Text(
                      DeveloperResponsibilities[index], // Replace with your subtitles
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.green, // Second line text color
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