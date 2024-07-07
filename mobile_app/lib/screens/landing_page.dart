import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<String> images = [
    'assets/landing_map.png',
    'assets/landing_armory.png',
  ];

  final List<String> imageTexts = [
    'Introducing the carry map. \nSee where you can, can\'t or popssiply carry.',
    'A simple armory to store your guns for ease of future lookups on carry laws.',
  ];

  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black.withOpacity(0.7), // Background color
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0), // Adjusted padding
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: images.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) {
                    return Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30), // Adjust border radius as needed
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover, // Adjust the fit as needed
                          // width: 300, // Adjust width as needed
                          // height: 300, // Adjust height as needed
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 190, // Adjust as needed
                  left: 50,
                  right: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(images.length, (index) {
                      return AnimatedContainer( /* circles */ 
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),
                Positioned(
                  bottom: 75, // Adjust as needed
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      imageTexts[_currentIndex],
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
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
