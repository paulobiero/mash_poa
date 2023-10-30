

import 'dart:async';

import 'package:mash/Widgets/drawer_user_controller.dart';
import 'package:mash/Widgets/home_drawer.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';


class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  late Widget screenView;
  late DrawerIndex drawerIndex;

  @override
  void initState() {

    drawerIndex = DrawerIndex.HOME;

    screenView = const Dashboard();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.grey.shade200,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            context: context,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = const SizedBox();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
         // screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          screenView = SizedBox();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          screenView = SizedBox();
        });
      } else {
        //do in your way......
      }
    }
  }
}
