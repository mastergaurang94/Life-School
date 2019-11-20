import 'package:flutter/material.dart';
import 'package:lifeschool/auth/widgets/login_screen.dart';

import 'package:lifeschool/explore/explore_widget.dart';
import 'package:lifeschool/my_masterminds/my_masterminds_widget.dart';
import 'package:lifeschool/profile/widgets/profile_screen_widget.dart';
import 'package:lifeschool/auth/login_bloc.dart';
import 'package:lifeschool/injection/dependency_injection.dart';

enum NavItem { explore, inbox, masterminds, facilitate, profile }

class HomeWidget extends StatefulWidget {
  final NavItem navItem;

  const HomeWidget({Key key, this.navItem}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState(currentIndex: this.navItem.index);
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  final LoginBloc _bloc = Injector().loginBloc;
  TabController tabController;
  int currentIndex;

  _HomeWidgetState({this.currentIndex});

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: NavItem.values.length, vsync: this);
    tabController.index = currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: tabController, children: [
        ExploreFeedWidget(),
        ProfileScreen(),
        MyMastermindsWidget(),
        ProfileScreen(),
        new FutureBuilder(
            future: getLoginOrProfileScreen(),
            initialData: CircularProgressIndicator(),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return snapshot.data;
              }
            },
        ),
      ]),
      bottomNavigationBar: Material(
        color: Colors.blueAccent,
        child: SafeArea(
          child: TabBar(
              controller: tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.transparent,
              tabs: [
                Tab(icon: Icon(Icons.search, size: 32.0)),
                Tab(icon: Icon(Icons.chat_bubble, size: 32.0)),
                Tab(icon: Icon(Icons.school, size: 32.0)), // TODO: replace with Life School logo
                Tab(icon: Icon(Icons.highlight, size: 32.0)),
                Tab(icon: Icon(Icons.person, size: 32.0))
              ]),
        ),
      ),
    );
  }

  Future<Widget> getLoginOrProfileScreen() async {
    Widget loginOrProfileScreen = (await _bloc.getUser()) == null ? LoginScreen() : ProfileScreen();
    return loginOrProfileScreen;
  }
}
