import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<String> images = [
    'assets/landing_map.png',
    'assets/landing_armory.png',
  ];

  final List<String> imageTexts = [
    'The carry map. \nSee where you can, can\'t or possibly carry.',
    'A tool for ease of future lookups on carry laws.',
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
        color: Colors.white, // Background color
        child: Center(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    // colors: [
                    //   Colors.blueAccent.withOpacity(.7),
                    //   Colors.purple.withOpacity(0.3),
                    // ],
                    colors: [
                      Colors.black.withOpacity(.7),
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(.7),
                      Colors.black.withOpacity(.1),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    40, 30, 40, 60), // Adjusted padding,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: images.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        return Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                30), // Adjust border radius as needed
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
                      bottom: 100, // Adjust as needed
                      left: 50,
                      right: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          images.length,
                          (index) {
                            return AnimatedContainer(
                              /* circles */
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
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0, // Adjust as needed
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          imageTexts[_currentIndex],
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: Alignment.topLeft,
                    //       end: Alignment.center,
                    //       colors: [
                    //         Colors.black.withOpacity(0.8),
                    //         Colors.black.withOpacity(0.4),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
