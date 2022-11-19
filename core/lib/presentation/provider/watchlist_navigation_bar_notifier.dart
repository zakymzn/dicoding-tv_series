import 'package:core/core.dart';
import 'package:flutter/material.dart';

class WatchlistNavigationBarNotifier extends ChangeNotifier {
  int currentIndex = 0;

  final List<Widget> pages = [
    WatchlistMoviesPage(),
    WatchlistTvPage(),
  ];

  currentPageIndex(int page) {
    currentIndex = page;
    notifyListeners();
  }
}
