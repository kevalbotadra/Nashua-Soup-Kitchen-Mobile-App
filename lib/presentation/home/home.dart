import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/presentation/account/screens/account.dart';
import 'package:nsks/presentation/posts/widgets/post_home_redirect.dart';
import 'package:nsks/presentation/statistic/widgets/statistic_redirect.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  void onTapTapped(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    setState(() {
      _currentIndex = index;
    });
  }

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

  EdgeInsets padding = Platform.isIOS
      ? const EdgeInsets.only(left: 10, right: 10, bottom: 10)
      : const EdgeInsets.only(left: 10, right: 10, bottom: 10);

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.green;
  Color unselectedColor = Colors.lightGreen;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        extendBody: true,
        body: PageView(
          controller: _pageController,
          onPageChanged: (newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          children: [
            PostPageRedirect(),
            StatisticRedirect(),
            AccountRedirect(),
          ],
        ),
        bottomNavigationBar: SnakeNavigationBar.color(
          backgroundColor: COLOR_GREEN, // Color.fromARGB(255, 139, 205, 141),
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          snakeViewColor: selectedColor,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: unselectedColor,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          currentIndex: _currentIndex,
          onTap: (index) async {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.ease);

            // setState(() {
            //   _currentIndex = index;
            // });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'feed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard), label: "statistic"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ],
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
