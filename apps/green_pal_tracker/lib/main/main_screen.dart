import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:green_pal_tracker/graph/ui/pages/battery/battery_screen.dart';
import 'package:green_pal_tracker/graph/ui/pages/house/house_screen.dart';
import 'package:green_pal_tracker/graph/ui/pages/solar/solar_screen.dart';
import 'package:green_pal_ui/theme/spacing.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.energy_savings_leaf),
            Gap(GreenPalSpacing.smallMedium),
            Text('GreenPal Tracker'),
            Spacer(),
            CircleAvatar(
              radius: 15,
              child: Icon(Icons.person, size: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.solar_power_outlined),
            activeIcon: Icon(Icons.solar_power),
            label: 'Solar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: 'House',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.battery_empty),
            activeIcon: Icon(CupertinoIcons.battery_full),
            label: 'Battery',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          SolarScreen(),
          HouseScreen(),
          BatteryScreen(),
        ],
      ),
    );
  }
}
