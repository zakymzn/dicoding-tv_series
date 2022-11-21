import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
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
