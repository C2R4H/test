import 'package:flutter/material.dart';

import '../data/network/network_service.dart';

import 'pages/explore_page.dart';
import 'pages/cart_page.dart';
import 'pages/user_page.dart';

class PageViewController extends StatefulWidget {
  @override
  PageViewControllerState createState() => PageViewControllerState();
}

class PageViewControllerState extends State<PageViewController> {

  NetworkService _networkService = NetworkService();

  @override
  void initState(){
    _networkService.getCategories(1,10).then((data){
    });
  }

  int _pageIndex = 0;

  final pages = [
    ExplorePage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (page) {
          setState(() {
            _pageIndex = page;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.trip_origin),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.trip_origin),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.trip_origin),
            label: 'User',
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Color(0xff121212),
        currentIndex: _pageIndex,
      ),
    );
  }
}
