import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:about/about.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
import 'package:search/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularMovies()
          ..fetchTopRatedMovies());
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pushReplacementNamed(context, HOME_TV_ROUTE);
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
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            key: Key('search_movie'),
            onPressed: () {
              Navigator.pushNamed(context, SEARCH_MOVIES_ROUTE);
            },
            icon: Icon(Icons.search),
          )
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
                    'Movies',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildSubHeading(
                title: 'Now Playing',
                valueKey: 'now_playing_movies',
                onTap: () =>
                    Navigator.pushNamed(context, NOW_PLAYING_MOVIES_ROUTE),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return MovieList(data.nowPlayingMovies);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                valueKey: 'popular_movies',
                onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_RUOTE),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                if (state == RequestState.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return MovieList(data.popularMovies);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                valueKey: 'top_rated_movies',
                onTap: () =>
                    Navigator.pushNamed(context, TOP_RATED_MOVIES_ROUTE),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.topRatedMoviesState;
                if (state == RequestState.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return MovieList(data.topRatedMovies);
                } else {
                  return Text('Failed');
                }
              }),
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
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
