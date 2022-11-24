import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/presentation/pages/watchlist_tv_page.dart';

class WatchListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
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
          title: Text('Watchlist'),
        ),
        body: TabBarView(children: [
          WatchlistMoviesPage(),
          WatchlistTvPage(),
        ]),
      ),
    );
  }
}
