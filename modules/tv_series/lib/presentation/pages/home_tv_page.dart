import 'package:about/about.dart';
import 'package:search/search.dart';
import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';
import 'package:movies/movies.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class HomeTvPage extends StatefulWidget {
  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchNowPlayingTv()
      ..fetchPopularTv()
      ..fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeMoviePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WATCHLIST_ROUTE);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_TV_ROUTE);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Tv Series',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildSubHeading(
                title: 'Now Playing',
                valueKey: 'now_playing_tv',
                onTap: () => Navigator.pushNamed(context, NOW_PLAYING_TV_ROUTE),
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.nowPlayingState;
                  if (state == RequestState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return TvList(data.nowPlayingTv);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                valueKey: 'popular_tv',
                onTap: () => Navigator.pushNamed(context, POPULAR_TV_ROUTE),
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.popularTvState;
                  if (state == RequestState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return TvList(data.popularTv);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                valueKey: 'top_rated_tv',
                onTap: () => Navigator.pushNamed(context, TOP_RATED_TV_ROUTE),
              ),
              Consumer<TvListNotifier>(
                builder: (context, data, child) {
                  final state = data.topRatedTvState;
                  if (state == RequestState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.loaded) {
                    return TvList(data.topRatedTv);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({
    required String title,
    required Function() onTap,
    required String valueKey,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          key: Key(valueKey),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        )
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvSeries;

  TvList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TV_DETAIL_ROUTE,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
