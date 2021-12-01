import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:puvts_driver/core/constants/puvts_colors.dart';
import 'package:puvts_driver/features/maps/presentation/screen/maps_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp),
            label: 'Driver',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: puvtsBlue,
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> _buildScreens = <Widget>[
    MapScreen(),
    Scaffold(
      body: Center(
        child: Text('This Page is Under Construction'),
      ),
    ),
  ];
}
