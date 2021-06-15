import 'package:blogsapp/constants/colors.dart';
import 'package:flutter/material.dart';

Widget buildBottomNavBar(int index, Function changeIndex, context) {
  return BottomNavigationBar(
    items: [
      _buildBottomNavBarItem(Icons.home, ""),
      _buildBottomNavBarItem(Icons.image, ""),
      _buildBottomNavBarItem(Icons.video_collection_outlined, ""),
      _buildBottomNavBarItem(Icons.account_circle, ""),
    ],
    onTap: (index) => changeIndex(
      context,
      index,
    ),
    showUnselectedLabels: false,
    showSelectedLabels: false,
    selectedItemColor: black,
    unselectedItemColor: grey,
    type: BottomNavigationBarType.fixed,
    selectedFontSize: 0,
    unselectedFontSize: 0,
    currentIndex: index,
  );
}

BottomNavigationBarItem _buildBottomNavBarItem(IconData icon, String label) {
  return BottomNavigationBarItem(
      icon: SizedBox(
        height: 42,
        child: Icon(icon),
      ),
      label: label);
}
