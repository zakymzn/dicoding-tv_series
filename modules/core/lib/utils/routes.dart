import 'package:about/about.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';

import 'utils.dart';

const homeMoviesRoute = '/home';
const nowPlayingMoviesRoute = '/now-playing-movie';
const popularMoviesRoute = '/popular-movie';
const topRatedMoviesRoute = '/top-rated-movie';
const movieDetailRoute = '/detail-movie';
const searchMoviesRoute = '/search-movie';

const homeTvRoute = '/tv-series';
const nowPlayingTvRoute = '/now-playing-route';
const popularTvRoute = '/popular-tv';
const topRatedTvRoute = '/top-rated-tv';
const tvDetailRoute = '/detail-tv';
const tvSeasonDetailRoute = '/detail-tv-season';
const tvEpisodeDetailRoute = '/detail-tv-episode';
const searchTvRoute = '/search-tv';

const aboutRoute = '/about';
const watchlistRoute = '/watchlist';

routeSettings() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case homeMoviesRoute:
        return MaterialPageRoute(builder: (_) => const HomeMoviePage());
      case nowPlayingMoviesRoute:
        return MaterialPageRoute(builder: (_) => const NowPlayingMoviesPage());
      case popularMoviesRoute:
        return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
      case topRatedMoviesRoute:
        return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
      case movieDetailRoute:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailPage(id: id),
          settings: settings,
        );
      case searchMoviesRoute:
        return CupertinoPageRoute(builder: (_) => const MovieSearchPage());
      case homeTvRoute:
        return MaterialPageRoute(builder: (_) => const HomeTvPage());
      case nowPlayingTvRoute:
        return MaterialPageRoute(builder: (_) => const NowPlayingTvPage());
      case popularTvRoute:
        return CupertinoPageRoute(builder: (_) => const PopularTvPage());
      case topRatedTvRoute:
        return CupertinoPageRoute(builder: (_) => const TopRatedTvPage());
      case tvDetailRoute:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => TvDetailPage(id: id),
          settings: settings,
        );
      case tvSeasonDetailRoute:
        final args = settings.arguments as MultiArgument;
        return MaterialPageRoute(builder: (_) {
          return TvSeasonDetailPage(
            id: args.arg1,
            seasonNumber: args.arg2,
          );
        });
      case tvEpisodeDetailRoute:
        final args = settings.arguments as TripleArgument;
        return MaterialPageRoute(
          builder: (_) {
            return TvEpisodeDetailPage(
              id: args.arg1,
              seasonNumber: args.arg2,
              episodeNumber: args.arg3,
            );
          },
          settings: settings,
        );
      case searchTvRoute:
        return CupertinoPageRoute(builder: (_) => const TvSearchPage());
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case watchlistRoute:
        return MaterialPageRoute(builder: (_) => const WatchListPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
    }
  };
}
