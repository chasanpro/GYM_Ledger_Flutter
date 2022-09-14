import 'package:animated_button/animated_button.dart';
import 'package:dharims_web/Dashboard.dart';
import 'package:dharims_web/Firebase/pending.dart';

import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Scaffold(
          floatingActionButton: SizedBox(
            child: AnimatedButton(
              color: Color.fromARGB(255, 63, 57, 58),
              height: 50,
              width: 50,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => dashboard()));
              },
              child: Icon(
                Icons.home,
                color: Color.fromARGB(255, 255, 215, 197),
              ),
            ),
          ),
          body: SizedBox.expand(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: <Widget>[
                pending(
                  limit: 8,
                  min: 0,
                ),
                pending(limit: 1, min: -1),
                pending(
                  limit: -1,
                  min: -1000,
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() => _currentIndex = index);
              _pageController.jumpToPage(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  activeColor: Color.fromARGB(255, 255, 215, 197),
                  title: Text('Week'),
                  icon: Icon(Icons.timeline)),
              BottomNavyBarItem(
                  activeColor: Color.fromARGB(255, 255, 215, 197),
                  title: Text('Today'),
                  icon: Icon(Icons.receipt_long)),
              BottomNavyBarItem(
                title: Text('Expired'),
                activeColor: Color.fromARGB(255, 255, 215, 197),
                icon: Icon(Icons.calendar_month),
              )
            ],
          ),
        ));
  }
}
