import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:murza_app/core/theme/colors.dart';

class NavBar extends CupertinoTabBar {
  /// NavBar для страниц из [CupertinoTabView] на [HomeScreen]
  NavBar({super.key, required ValueChanged<int> onTab})
    : super(
        onTap: onTab,
        activeColor: MurzaColors.primaryColor,
        currentIndex: 0,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Товары",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: "Заказы",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
          ),
        ],
        border: const Border(
          top: BorderSide(color: Colors.black38, width: 0.7),
        ),
        backgroundColor: Colors.white,
      );
}
