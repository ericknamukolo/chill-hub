import 'package:chill_hub/constants/colors.dart';
import 'package:chill_hub/constants/text_style.dart';
import 'package:chill_hub/screens/mobile/search_nav_screen.dart';
import 'package:chill_hub/widgets/mobile_widgets/cutsom_app_bar.dart';
import 'package:flutter/material.dart';

import 'about_nav_screen.dart';
import 'home_nav_screen.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  State<MobileHome> createState() => _MobileHome();
}

class _MobileHome extends State<MobileHome> with TickerProviderStateMixin {
  TabController? tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  final tabs = [
    const HomeScreen(),
    Container(),
    const SearchNavScreen(),
    const AboutNavScreen(),
  ];
  String getAppBarText() {
    if (_currentIndex == 0) {
      return 'Home';
    } else if (_currentIndex == 1) {
      return 'Categories';
    } else if (_currentIndex == 2) {
      return 'Search';
    } else if (_currentIndex == 3) {
      return 'About';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getAppBarText(),
        icon: const SizedBox(),
      ),
      backgroundColor: kPrimaryColorDark,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10.0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            tabController!.index = _currentIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kAccentColor,
        backgroundColor: kSecondaryColorDark.withOpacity(.5),
        showUnselectedLabels: true,
        unselectedFontSize: 10,
        unselectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedItemColor: Colors.white,
        selectedLabelStyle: kMobileBodyTextStyleWhite,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_rounded),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
