import 'package:flutter/material.dart';

class Armory extends StatefulWidget {
  @override
  _ArmoryState createState() => _ArmoryState();
}

class _ArmoryState extends State<Armory> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'Pistol', 'image': 'lib/img/pistol.png'},
    {'name': 'Shotgun', 'image': 'lib/img/shotgun.png'},
    {'name': 'Rifle', 'image': 'lib/img/rifle.png'},
  ];

  int _hoverIndex = -1;

  void _onItemTapped(String name) {
    // Implement your action here. For now, we'll just print the name.
    print('Tapped on $name');
  }

  void _onHoverStart(int index) {
    setState(() {
      _hoverIndex = index;
    });
  }

  void _onHoverEnd() {
    setState(() {
      _hoverIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Armory'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return MouseRegion(
            onEnter: (_) => _onHoverStart(index),
            onExit: (_) => _onHoverEnd(),
            child: InkWell(
              onTap: () => _onItemTapped(_items[index]['name']),
              child: Card(
                color: _hoverIndex == index ? Colors.grey[300] : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      _items[index]['image'],
                      height: 80.0,
                      width: 80.0,
                    ),
                    SizedBox(height: 8.0),
                    Text(_items[index]['name']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
