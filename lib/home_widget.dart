import 'package:flutter/material.dart';

import 'package:lifeschool/explore/explore_widget.dart';
import 'package:lifeschool/my_masterminds/my_masterminds_widget.dart';

enum NavItem { explore, inbox, masterminds, profile }

class HomeWidget extends StatefulWidget {
  final NavItem navItem;

  const HomeWidget({Key key, this.navItem}): super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState(currentIndex: this.navItem.index);
}

class _HomeWidgetState extends State<HomeWidget> {
  int currentIndex;

  _HomeWidgetState({ this.currentIndex });

  final List<Widget> _children = [
    ExploreFeedWidget(),
    ExploreFeedWidget(),
    MyMastermindsWidget(),
    MyMastermindsWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Life School'),
      ),
      body: _children[currentIndex],
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  void _onTabTapped(BuildContext context, int index) {
    setState(() => currentIndex = index);
  }

  Widget _buildBottomNavigation() {
    const selectedIcons = <IconData>[
      Icons.search,
      Icons.chat_bubble,
      Icons.school, // TODO: replace with Life School logo
      Icons.person,

    ];
    const unselectedIcons = <IconData>[
      Icons.search,
      Icons.chat_bubble_outline,
      Icons.school,
      Icons.person_outline,
    ];

    assert(selectedIcons.length == unselectedIcons.length);
    assert(_children.length == selectedIcons.length);

    final bottomNavigationItems = List.generate(selectedIcons.length, (int i) {
      final iconData =
      currentIndex == i ? selectedIcons[i] : unselectedIcons[i];
      return BottomNavigationBarItem(icon: Icon(iconData), title: Container());
    }).toList();

    return Builder(builder: (BuildContext context) {
      return BottomNavigationBar(
        iconSize: 32.0,
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationItems,
        currentIndex: currentIndex,
        onTap: (int i) => _onTabTapped(context, i),
      );
    });
  }
}
