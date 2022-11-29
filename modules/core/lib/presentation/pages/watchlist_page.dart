import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/presentation/pages/watchlist_tv_page.dart';

class WatchListPage extends StatelessWidget {
  const WatchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: kMikadoYellow,
            unselectedLabelColor: Colors.white,
            indicatorColor: kMikadoYellow,
            tabs: [
              Tab(
                icon: Icon(Icons.movie),
                text: 'Movie',
              ),
              Tab(
                icon: Icon(Icons.tv),
                text: 'TV',
              ),
            ],
          ),
          title: const Text('Watchlist'),
        ),
        body: const TabBarView(children: [
          WatchlistMoviesPage(),
          WatchlistTvPage(),
        ]),
      ),
    );
  }
}
