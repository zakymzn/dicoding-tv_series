import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchListPage extends StatefulWidget {
  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistNavigationBarNotifier>(
      builder: (context, page, child) => Scaffold(
        body: page.pages[page.currentIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.amber.shade100,
            iconTheme: const MaterialStatePropertyAll(
              IconThemeData(
                color: Colors.white,
              ),
            ),
            labelTextStyle: const MaterialStatePropertyAll(
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          child: NavigationBar(
            onDestinationSelected: (index) {
              page.currentPageIndex(index);
            },
            animationDuration: const Duration(milliseconds: 500),
            selectedIndex: page.currentIndex,
            backgroundColor: Colors.amber.shade300,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.movie_outlined),
                selectedIcon: Icon(
                  Icons.movie,
                  color: Colors.amber,
                ),
                label: 'Movie Watchlist',
              ),
              NavigationDestination(
                icon: Icon(Icons.tv_outlined),
                selectedIcon: Icon(
                  Icons.tv,
                  color: Colors.amber,
                ),
                label: 'TV Watchlist',
              )
            ],
          ),
        ),
      ),
    );
  }
}
