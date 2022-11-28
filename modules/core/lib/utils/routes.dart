import 'package:about/about.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';

import 'utils.dart';

const HOME_MOVIES_ROUTE = '/home';
const NOW_PLAYING_MOVIES_ROUTE = '/now-playing-movie';
const POPULAR_MOVIES_RUOTE = '/popular-movie';
const TOP_RATED_MOVIES_ROUTE = '/top-rated-movie';
const MOVIE_DETAIL_ROUTE = '/detail-movie';
const SEARCH_MOVIES_ROUTE = '/search-movie';

const HOME_TV_ROUTE = '/tv-series';
const NOW_PLAYING_TV_ROUTE = '/now-playing-route';
const POPULAR_TV_ROUTE = '/popular-tv';
const TOP_RATED_TV_ROUTE = '/top-rated-tv';
const TV_DETAIL_ROUTE = '/detail-tv';
const TV_SEASON_DETAIL_ROUTE = '/detail-tv-season';
const TV_EPISODE_DETAIL_ROUTE = '/detail-tv-episode';
const SEARCH_TV_ROUTE = '/search-tv';

const ABOUT_ROUTE = '/about';
const WATCHLIST_ROUTE = '/watchlist';

routeSettings() {
  return (RouteSettings settings) {
    switch (settings.name) {
      case HOME_MOVIES_ROUTE:
        return MaterialPageRoute(builder: (_) => HomeMoviePage());
      case NOW_PLAYING_MOVIES_ROUTE:
        return MaterialPageRoute(builder: (_) => NowPlayingMoviesPage());
      case POPULAR_MOVIES_RUOTE:
        return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
      case TOP_RATED_MOVIES_ROUTE:
        return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
      case MOVIE_DETAIL_ROUTE:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailPage(id: id),
          settings: settings,
        );
      case SEARCH_MOVIES_ROUTE:
        return CupertinoPageRoute(builder: (_) => MovieSearchPage());
      case HOME_TV_ROUTE:
        return MaterialPageRoute(builder: (_) => HomeTvPage());
      case NOW_PLAYING_TV_ROUTE:
        return MaterialPageRoute(builder: (_) => NowPlayingTvPage());
      case POPULAR_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => PopularTvPage());
      case TOP_RATED_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
      case TV_DETAIL_ROUTE:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => TvDetailPage(id: id),
          settings: settings,
        );
      case TV_SEASON_DETAIL_ROUTE:
        final args = settings.arguments as MultiArgument;
        return MaterialPageRoute(builder: (_) {
          return TvSeasonDetailPage(
            id: args.arg1,
            seasonNumber: args.arg2,
          );
        });
      case TV_EPISODE_DETAIL_ROUTE:
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
      case SEARCH_TV_ROUTE:
        return CupertinoPageRoute(builder: (_) => TvSearchPage());
      case ABOUT_ROUTE:
        return MaterialPageRoute(builder: (_) => AboutPage());
      case WATCHLIST_ROUTE:
        return MaterialPageRoute(builder: (_) => WatchListPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
    }
  };
}
