import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/movie_bloc_test_helper.dart';
import '../../dummy_data/movie_dummy_objects.dart';

import '../../../../tv_series/test/helpers/tv_bloc_test_helper.dart';
import '../../../../search/test/helpers/search_movie_bloc_test_helper.dart';

void main() {
  late MockNowPlayingMoviesBloc mockNowPlayingMoviesBloc;
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  late MockNowPlayingTvBloc mockNowPlayingTvBloc;
  late MockPopularTvBloc mockPopularTvBloc;
  late MockTopRatedTvBloc mockTopRatedTvBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  late MockSearchMoviesBloc mockSearchMoviesBloc;

  setUp(
    () {
      mockNowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
      mockPopularMoviesBloc = MockPopularMoviesBloc();
      mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
      mockMovieWatchlistBloc = MockMovieWatchlistBloc();

      mockNowPlayingTvBloc = MockNowPlayingTvBloc();
      mockPopularTvBloc = MockPopularTvBloc();
      mockTopRatedTvBloc = MockTopRatedTvBloc();
      mockTvWatchlistBloc = MockTvWatchlistBloc();

      mockSearchMoviesBloc = MockSearchMoviesBloc();

      registerFallbackValue(FakeMovieEvent());
      registerFallbackValue(FakeMovieState());

      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());

      registerFallbackValue(FakeSearchMoviesEvent());
      registerFallbackValue(FakeSearchMoviesState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => mockNowPlayingMoviesBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => mockPopularMoviesBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => mockTopRatedMoviesBloc,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockMovieWatchlistBloc,
        ),
        BlocProvider<NowPlayingTvBloc>(
          create: (context) => mockNowPlayingTvBloc,
        ),
        BlocProvider<PopularTvBloc>(
          create: (context) => mockPopularTvBloc,
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (context) => mockTopRatedTvBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => mockTvWatchlistBloc,
        ),
        BlocProvider<SearchMoviesBloc>(
          create: (context) => mockSearchMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routeSettings(),
      ),
    );
  }

  testWidgets('Page should display center progress indicator when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMoviesBloc.state).thenReturn(MovieLoading());
    when(() => mockPopularMoviesBloc.state).thenReturn(MovieLoading());
    when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieLoading());

    final progressIndicatorFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(centerFinder, findsWidgets);
    expect(progressIndicatorFinder, findsWidgets);
  });

  testWidgets(
    'Page should display ListView when data is loaded',
    (widgetTester) async {
      when(() => mockNowPlayingMoviesBloc.state)
          .thenReturn(MovieListHasData(testMovieList));
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(MovieListHasData(testMovieList));
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(MovieListHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await widgetTester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(listViewFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (widgetTester) async {
      when(() => mockNowPlayingMoviesBloc.state)
          .thenReturn(MovieError('Failed'));
      when(() => mockPopularMoviesBloc.state).thenReturn(MovieError('Failed'));
      when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieError('Failed'));

      final textFinder = find.byType(Text);

      await widgetTester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(textFinder, findsWidgets);
      expect(find.text('Failed'), findsWidgets);
    },
  );

  testWidgets(
    'Page should be scrollable',
    (widgetTester) async {
      when(() => mockNowPlayingMoviesBloc.state)
          .thenReturn(MovieListHasData(testMovieList));
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(MovieListHasData(testMovieList));
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(MovieListHasData(testMovieList));

      final scrollableFinder = find.byType(Scrollable);

      final nowPlayingMoviesFinder = find.byKey(ValueKey('now_playing_movies'));
      final popularMoviesFinder = find.byKey(ValueKey('popular_movies'));
      final topRatedMoviesFinder = find.byKey(ValueKey('top_rated_movies'));

      await widgetTester.pumpWidget(_makeTestableWidget(HomeMoviePage()));
      await widgetTester.scrollUntilVisible(nowPlayingMoviesFinder, 500,
          scrollable: scrollableFinder.first);
      expect(nowPlayingMoviesFinder, findsOneWidget);

      await widgetTester.scrollUntilVisible(popularMoviesFinder, 500,
          scrollable: scrollableFinder.first);
      expect(popularMoviesFinder, findsOneWidget);

      await widgetTester.scrollUntilVisible(topRatedMoviesFinder, 500,
          scrollable: scrollableFinder.first);
      expect(topRatedMoviesFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should have a drawer and contain ListTile for navigate to another page',
    (widgetTester) async {
      when(() => mockNowPlayingMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockMovieWatchlistBloc.state).thenReturn(MovieEmpty());

      when(() => mockNowPlayingTvBloc.state).thenReturn(TvEmpty());
      when(() => mockPopularTvBloc.state).thenReturn(TvEmpty());
      when(() => mockTopRatedTvBloc.state).thenReturn(TvEmpty());
      when(() => mockTvWatchlistBloc.state).thenReturn(TvEmpty());

      await widgetTester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      final ScaffoldState movieScaffoldState =
          widgetTester.firstState(find.byType(Scaffold));

      movieScaffoldState.openDrawer();
      await widgetTester.pumpAndSettle();

      final movieIconFinder = find.byIcon(Icons.movie);
      final tvIconFinder = find.byIcon(Icons.tv);
      final watchlistIconFinder = find.byIcon(Icons.save_alt);
      final aboutIconFinder = find.byIcon(Icons.info_outline);
      final backIconFinder = find.byIcon(Icons.arrow_back);

      expect(movieIconFinder, findsOneWidget);

      await widgetTester.tap(movieIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(HomeMoviePage), findsOneWidget);

      movieScaffoldState.openDrawer();
      await widgetTester.pumpAndSettle();

      expect(watchlistIconFinder, findsOneWidget);

      await widgetTester.tap(watchlistIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(WatchListPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(aboutIconFinder, findsOneWidget);

      await widgetTester.tap(aboutIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(AboutPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(tvIconFinder, findsOneWidget);

      await widgetTester.tap(tvIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(HomeTvPage), findsOneWidget);
    },
  );

  testWidgets(
    'Page should navigate to search movies page when search icon is tapped',
    (widgetTester) async {
      when(() => mockNowPlayingMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockSearchMoviesBloc.state).thenReturn(SearchMoviesEmpty());

      await widgetTester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      final searchIconFinder = find.byIcon(Icons.search);
      final backIconFinder = find.byIcon(Icons.arrow_back);

      expect(searchIconFinder, findsOneWidget);

      await widgetTester.tap(searchIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(MovieSearchPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(HomeMoviePage), findsOneWidget);
    },
  );

  testWidgets(
    'Page should be able to navigate to now playing movies page, popular movies page, and top rated movies page',
    (widgetTester) async {
      when(() => mockNowPlayingMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieEmpty());

      await widgetTester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      final nowPlayingMoviesPageKey =
          find.byKey(ValueKey('now_playing_movies'));
      final popularMoviesPageKey = find.byKey(ValueKey('popular_movies'));
      final topRatedMoviesPageKey = find.byKey(ValueKey('top_rated_movies'));
      final backIconFinder = find.byIcon(Icons.arrow_back);

      expect(nowPlayingMoviesPageKey, findsOneWidget);

      await widgetTester.tap(nowPlayingMoviesPageKey);
      await widgetTester.pumpAndSettle();

      expect(find.byType(NowPlayingMoviesPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(popularMoviesPageKey, findsOneWidget);

      await widgetTester.tap(popularMoviesPageKey);
      await widgetTester.pumpAndSettle();

      expect(find.byType(PopularMoviesPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(topRatedMoviesPageKey, findsOneWidget);

      await widgetTester.tap(topRatedMoviesPageKey);
      await widgetTester.pumpAndSettle();

      expect(find.byType(TopRatedMoviesPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(HomeMoviePage), findsOneWidget);
    },
  );
}
