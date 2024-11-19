import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarExample extends StatefulWidget {
  @override
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBarExample> {
  int _selectedIndex = 0;

  final List<String> _icons = [
    'assets/img/Bed.svg',
    'assets/img/door_open.svg',
    'assets/img/gear.svg',
    'assets/img/moon_plus.svg',
  ];

  final List<String> _labels = ['Bed', 'Door', 'Settings', 'Moon'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Navigation Example')),
      body: Center(
        child: Text(
          'Selected: ${_labels[_selectedIndex]}',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(_icons.length, (index) {
          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _icons[index],
              width: 24,
              height: 24,
            ),
            label: _labels[index],
          );
        }),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BottomNavBarExample(),
  ));
}