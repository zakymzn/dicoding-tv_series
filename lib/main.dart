import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
import 'package:about/about.dart';
import 'package:search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistNavigationBarNotifier>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBlocr>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [
          routeObserver,
        ],
        onGenerateRoute: (RouteSettings settings) {
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
        },
      ),
    );
  }
}
