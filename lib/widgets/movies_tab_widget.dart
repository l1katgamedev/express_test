import 'package:express_test/screens/popular.dart';
import 'package:express_test/screens/trending.dart';
import 'package:express_test/screens/upcoming.dart';
import 'package:express_test/utils.dart';
import 'package:flutter/material.dart';

class MoviesTabWidget extends StatefulWidget {
  const MoviesTabWidget({Key? key}) : super(key: key);

  @override
  State<MoviesTabWidget> createState() => _MoviesTabWidgetState();
}

class _MoviesTabWidgetState extends State<MoviesTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        controller: pageController,
        children: const [
          PopularScreen(),
          TrendingScreen(),
          UpcomingScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Colors.tealAccent,
        shape:const  CircularNotchedRectangle(),
        // notchMargin: 5,
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _navItem(0, Icons.star, 'Popular'),
                _navItem(1, Icons.trending_up, 'Trending'),
                _navItem(2, Icons.upcoming, 'Upcoming'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  _navItem(int index, icon, label) {
    return InkWell(
      onTap: () {
        onPageChanged(index);
        onTabTapped(index);
      },
      splashColor: Colors.transparent,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: pageIndex == index ? Colors.teal : Colors.grey[600],
            ),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 100),
              style: TextStyle(
                color: pageIndex == index ? Colors.teal : Colors.grey[600],
                fontSize: pageIndex == index ? 12 : 10,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
