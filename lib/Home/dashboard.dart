import 'dart:convert';
import 'dart:math';
import 'package:mash/About/About.dart';
import 'package:mash/AccountSettings/ProfileSettings.dart';
import 'package:mash/AuthenticationPages/AuthLandingPage.dart';
import 'package:mash/Home/NavigationPages/MyWallet.dart';
import 'package:mash/Models/userInfo.dart';
import 'package:mash/Services/AuthenticationServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'NavigationPages/MyHomePage.dart';
import 'NavigationPages/MyTicketsPage.dart';

import 'NavigationPages/MyTripsPage.dart';
import 'NavigationPages/TripHistoryPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  _Dashboard createState() => _Dashboard();
}

class MyTextWidget extends StatelessWidget {
  final String text;

  const MyTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
    );
  }
}

class _Dashboard extends State<Dashboard> with TickerProviderStateMixin {
  double currentPage = 0;

  bool canCheckBiometrics = false;
  bool notification = false, isTerms = true;
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;
  late PersistentTabController _tabController;

  bool isSeletced = false;

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Account actions'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            isDefaultAction: false,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                   ProfileSettings(),
                ),
              );
            },
            child: const Text(
              'My Profile',
              style: TextStyle(color: Colors.black),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MyWalletLanding(),

                ),
              );
            },
            child: const Text(
              'My Wallet',
              style: TextStyle(color: Colors.black),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => MyTicketsPage(title: "", buildContext: context,),

                ),
              );
            },
            child: const Text(
              'My trips',
              style: TextStyle(color: Colors.black),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => AboutLandingPage(title: "",),

                ),
              );
            },
            child: const Text(
              'About',
              style: TextStyle(color: Colors.black),
            ),
          ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              AuthenticationServices().removeUser().then((value) => {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const AuthLandingPage(title: ''),
                      ),(route) => false
                    )
                  });
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }

  IconData floatingActionIcon = Icons.event;
  int touchedIndex = -1;
  bool isLoadnData = true;
  var loadingError = {};
  List colors = [Colors.red, Colors.green, Colors.yellow, Colors.blue];

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }

  late TabController _tabController2;
  final bodyGlobalKey = GlobalKey();
  final List<Widget> myTabs = [
    Tab(text: 'History'),
    Tab(text: 'Statistics'),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: Colors.yellow.shade700,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.arrow_clockwise),
        title: ("Trip History"),
        activeColorPrimary: Colors.yellow.shade700,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.ticket),
        title: ("My Tickets"),
        activeColorPrimary: Colors.yellow.shade700,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    _tabController = PersistentTabController(initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          floatingActionIcon = Icons.event;
        } else {
          floatingActionIcon = Icons.search;
        }
      });
    });
    _tabController2 = TabController(vsync: this, length: 2);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    animationController.forward();
    getUser().then((value) => {});

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = true;

  UserInfo _userInfoinfo = UserInfo();

  late AnimationController animationController;
  static final double containerHeight = 170.0;
  double clipHeight = containerHeight * 0.35;

  final size = 200.0;
  PageController _controller = PageController(
    initialPage: 0,
  );

  Future<void> getUser() async {
    bool returnnr = await AuthenticationServices().IsSignedIn();
    if (returnnr) {
      UserInfo info = await AuthenticationServices().getUser();
      setState(() {
        _userInfoinfo = info;
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  int touchedGroupIndex = -1;
  int count = 1;
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black),
          title: Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              "Let's book your\nbus ticket 🚌",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          toolbarHeight: size.height * .13,
          actions: [
            GestureDetector(
              onTap: () async {},
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: isLoggedIn
                    ? Container(
                        height: 40,
                        width: 40,
                        child: TextDrawable(
                          text: _userInfoinfo.name,
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          isTappable: true,
                          isSelected: isSeletced,
                          onTap: (val) {
                            _showActionSheet(context);
                            setState(() {
                              isSeletced = false;
                            });
                          },
                        ),
                      )
                    : Container(
                        width: 35.0,
                        height: 35.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            image: const DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                    'assets/images/circle_cropped.png')))),
              ),
            ),
          ],

          centerTitle: false,
          // title:Text.rich(
          //   TextSpan(
          //     style: Theme.of(context).textTheme.headline6.copyWith(
          //       color: ArgonColors.primaryColor,fontWeight: FontWeight.w700,
          //
          //
          //     ),
          //     text: "SHE",
          //     children: <TextSpan>[
          //       TextSpan(text: 'Bnks', style:Theme.of(context).textTheme.headline6.copyWith(
          //         color: Colors.black,
          //         fontWeight: FontWeight.w700,
          //
          //       )),
          //
          //     ],
          //   ),textAlign:  TextAlign.center,
          // ),
        ),

        body: MyHomePage(title: "", buildContext: context));
  }
}
