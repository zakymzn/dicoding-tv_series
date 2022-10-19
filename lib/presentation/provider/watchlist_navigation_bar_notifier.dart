import 'package:ditonton/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/watchlist_tv_page.dart';
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
