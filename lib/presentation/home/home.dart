import 'package:flutter/material.dart';
import 'package:nsks/helpers/constants.dart';
import 'package:nsks/presentation/account/screens/account.dart';
import 'package:nsks/presentation/posts/screens/statistic.dart';
import 'package:nsks/presentation/posts/widgets/post_list_redirect.dart';
import 'package:nsks/presentation/posts/widgets/statistic_redirect.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
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
          bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Color(0x00ffffff),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  // fixedColor: Colors.white,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.green,
                  backgroundColor: COLOR_GREEN,
                  onTap: onTapTapped,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: new Icon(Icons.home_outlined, size: 30),
                        label: "Posts"),
                    BottomNavigationBarItem(
                        icon: new Icon(Icons.leaderboard_outlined, size: 30),
                        label: "Statistics"),
                    BottomNavigationBarItem(
                        icon: new Icon(Icons.person_outlined, size: 30),
                        label: "Account"),
                  ],
                ),
              ))),
    );
  }
}
