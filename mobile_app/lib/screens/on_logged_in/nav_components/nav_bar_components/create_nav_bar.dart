import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:gun/screens/on_logged_in/main_features/reciprocity.dart';
import '../../main_features/map_page.dart';
import '../../main_features/armory_page.dart';
import 'create_page_app_bar.dart';
import '../drawer_components/create_drawer.dart';
import '../../../../api/persist.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  int index = 0;
  final screens = [MapPage(), Armory(), ReciprocityPage()];
  final titles = ['Concealed Carry Map', 'Armory', 'Reciprocity Map'];
  final PreferencesHelper _prefsHelper = PreferencesHelper();

  // @override
  // void initState() {
  //   super.initState();
    
  // }

  Future<void> _initialize() async {
    // Awaiting an asynchronous operation here
    await _prefsHelper.processStoredLoginResponse();
    // Other initialization code if needed
  }


  late AnimationController animationController;
  static const double maxSlide = 225.0;
  bool canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _initialize();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggleDrawer() {
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  void onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed && details.globalPosition.dx < 100;
    bool isDragCloseFromRight = animationController.isCompleted && details.globalPosition.dx > maxSlide;

    canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      animationController.value += delta;
    }
  }

  void onDragEnd(DragEndDetails details) {
    if (animationController.isDismissed || animationController.isCompleted) return;

    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / maxSlide;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Stack(
            children: [
              // Drawer
              Transform.translate(
                offset: Offset(maxSlide * (animationController.value - 1), 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(math.pi / 2 * (1 - animationController.value)),
                  alignment: Alignment.centerRight,
                  child: MyDrawer(),
                ),
              ),
              // Main content including Scaffold
              Transform.translate(
                offset: Offset(maxSlide * animationController.value, 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-math.pi / 2 * animationController.value),
                  alignment: Alignment.centerLeft,
                  child: Scaffold(
                    appBar: PageAppBar(
                      title: titles[index],
                      onMenuPressed: toggleDrawer,
                    ),
                    body: Stack(
                      children: [
                        SafeArea(child: screens[index]),
                        Positioned(
                          bottom: 5.0,
                          left: 0,
                          right: 0,
                          child: Visibility(
                            visible: index != 1,
                            child: Center(
                              child: TextButton(
                                onPressed: () => setState(() => index = (index == 2 ? 0 : 2)),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 26.0),
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: Text(index == 2 ? 'Show Concealed Carry' : 'Show Reciprocity'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    bottomNavigationBar: NavigationBarTheme(
                      data: NavigationBarThemeData(
                        indicatorColor: Colors.red,
                        backgroundColor: Colors.black,
                        labelTextStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
                      ),
                      child: NavigationBar(
                        height: 70,
                        selectedIndex: index == 2 ? 0 : index,
                        onDestinationSelected: (index) => setState(() => this.index = index),
                        destinations: const [
                          NavigationDestination(
                            icon: Icon(Icons.map_outlined, color: Colors.white),
                            selectedIcon: Icon(Icons.map, color: Colors.white),
                            label: 'Map',
                          ),
                          NavigationDestination(
                            icon: Icon(Icons.cases_outlined, color: Colors.white),
                            selectedIcon: Icon(Icons.cases_rounded, color: Colors.white),
                            label: 'Armory',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
