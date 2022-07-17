import 'package:curved_navigation_rail/curved_navigation_rail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CurvedNavigationRailExamplePage(),
    );
  }
}

class CurvedNavigationRailExamplePage extends StatefulWidget {
  const CurvedNavigationRailExamplePage({Key? key}) : super(key: key);

  @override
  State<CurvedNavigationRailExamplePage> createState() =>
      _CurvedNavigationRailExamplePageState();
}

class _CurvedNavigationRailExamplePageState
    extends State<CurvedNavigationRailExamplePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<NavigationRailDestination> destinations = const [
      NavigationRailDestination(
          icon: Icon(Icons.person), label: Text('Profile')),
      NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
      NavigationRailDestination(
          icon: Icon(Icons.settings), label: Text('Settings')),
    ];

    return Scaffold(
        body: Row(
      children: [
        CurvedNavigationRail(
          destinations: destinations,
          onDestinationSelected: (index) =>
              setState(() => _selectedIndex = index),
        ),
        MyContent(value: _selectedIndex),
      ],
    ));
  }
}

class MyContent extends StatelessWidget {
  const MyContent({Key? key, required this.value}) : super(key: key);

  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: Text('This is Page $value')));
  }
}
