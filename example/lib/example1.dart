import 'package:flutter/material.dart';
import 'package:curved_navigation_rail/curved_navigation_rail.dart';

void main() => runApp(MaterialApp(home: CurvedNavigationRailExample()));

class CurvedNavigationRailExample extends StatefulWidget {
  @override
  _CurvedNavigationRailExampleState createState() =>
      _CurvedNavigationRailExampleState();
}

class _CurvedNavigationRailExampleState
    extends State<CurvedNavigationRailExample> {
  int _page = 0;
  GlobalKey<CurvedNavigationRailState> _bottomNavigationKey = GlobalKey();

  final List<Widget> destinationsOld = [
    Icon(Icons.add, size: 30),
    Icon(Icons.list, size: 30),
    Icon(Icons.compare_arrows, size: 30),
    Icon(Icons.call_split, size: 30),
    Icon(Icons.perm_identity, size: 30),
  ];

  final List<NavigationRailDestination> destinations = [
    NavigationRailDestination(
      icon: Icon(Icons.add),
      label: Text('First'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.list),
      label: Text('Second'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.compare_arrows),
      label: Text('Third'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.call_split),
      label: Text('Fourth'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.perm_identity),
      label: Text('Fifth'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationRail(
          key: _bottomNavigationKey,
          selectedIndex: 0,
          width: 60.0,
          destinations: destinations,
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blue,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onDestinationSelected: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.blue,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                ElevatedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    final CurvedNavigationRailState? navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState?.setPage(1);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
