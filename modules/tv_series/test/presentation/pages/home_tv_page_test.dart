import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

import '../../../../movies/test/helpers/movie_bloc_test_helper.dart';
import '../../../../search/test/helpers/search_tv_bloc_test_helper.dart';

void main() {
  late MockNowPlayingTvBloc mockNowPlayingTvBloc;
  late MockPopularTvBloc mockPopularTvBloc;
  late MockTopRatedTvBloc mockTopRatedTvBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  late MockNowPlayingMoviesBloc mockNowPlayingMoviesBloc;
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  late MockSearchTvBloc mockSearchTvBloc;

  setUp(
    () {
      mockNowPlayingTvBloc = MockNowPlayingTvBloc();
      mockPopularTvBloc = MockPopularTvBloc();
      mockTopRatedTvBloc = MockTopRatedTvBloc();
      mockTvWatchlistBloc = MockTvWatchlistBloc();

      mockNowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
      mockPopularMoviesBloc = MockPopularMoviesBloc();
      mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
      mockMovieWatchlistBloc = MockMovieWatchlistBloc();

      mockSearchTvBloc = MockSearchTvBloc();

      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());

      registerFallbackValue(FakeMovieEvent());
      registerFallbackValue(FakeMovieState());

      registerFallbackValue(FakeSearchTvEvent());
      registerFallbackValue(FakeSearchTvState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
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
        BlocProvider<SearchTvBloc>(
          create: (context) => mockSearchTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routeSettings(),
      ),
    );
  }

  testWidgets(
    'Page should display center progress indicator when loading',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(TvLoading());
      when(() => mockPopularTvBloc.state).thenReturn(TvLoading());
      when(() => mockTopRatedTvBloc.state).thenReturn(TvLoading());

      final progressIndicatorFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(centerFinder, findsWidgets);
      expect(progressIndicatorFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockPopularTvBloc.state).thenReturn(TvListHasData(testTvList));
      when(() => mockTopRatedTvBloc.state)
          .thenReturn(TvListHasData(testTvList));

      final listViewFinder = find.byType(ListView);

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(listViewFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(TvError('Failed'));
      when(() => mockPopularTvBloc.state).thenReturn(TvError('Failed'));
      when(() => mockTopRatedTvBloc.state).thenReturn(TvError('Failed'));

      final textFinder = find.byType(Text);

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(textFinder, findsWidgets);
      expect(find.text('Failed'), findsWidgets);
    },
  );

  testWidgets(
    'Page should be scrollable',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockPopularTvBloc.state).thenReturn(TvListHasData(testTvList));
      when(() => mockTopRatedTvBloc.state)
          .thenReturn(TvListHasData(testTvList));

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final tvItemFinder = find.byKey(ValueKey('tv_$index'));
      final nowPlayingTvFinder = find.byKey(ValueKey('now_playing_tv'));
      final popularTvFinder = find.byKey(ValueKey('popular_tv'));
      final topRatedTvFinder = find.byKey(ValueKey('top_rated_tv'));

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));
      await widgetTester.scrollUntilVisible(nowPlayingTvFinder, 500,
          scrollable: scrollableFinder.first);
      expect(nowPlayingTvFinder, findsOneWidget);

      await widgetTester.scrollUntilVisible(popularTvFinder, 500,
          scrollable: scrollableFinder.first);
      expect(popularTvFinder, findsOneWidget);

      await widgetTester.scrollUntilVisible(topRatedTvFinder, 500,
          scrollable: scrollableFinder.first);
      expect(topRatedTvFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should have a drawer and contain ListTile for navigate to another page',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(TvEmpty());
      when(() => mockPopularTvBloc.state).thenReturn(TvEmpty());
      when(() => mockTopRatedTvBloc.state).thenReturn(TvEmpty());
      when(() => mockTvWatchlistBloc.state).thenReturn(TvEmpty());

      when(() => mockNowPlayingMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockMovieWatchlistBloc.state).thenReturn(MovieEmpty());

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      final ScaffoldState tvScaffoldState =
          widgetTester.firstState(find.byType(Scaffold));

      tvScaffoldState.openDrawer();
      await widgetTester.pumpAndSettle();

      final movieIconFinder = find.byIcon(Icons.movie);
      final tvIconFinder = find.byIcon(Icons.tv);
      final watchlistIconFinder = find.byIcon(Icons.save_alt);
      final aboutIconFinder = find.byIcon(Icons.info_outline);
      final backIconFinder = find.byIcon(Icons.arrow_back);

      expect(tvIconFinder, findsOneWidget);

      await widgetTester.tap(tvIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(HomeTvPage), findsOneWidget);

      tvScaffoldState.openDrawer();
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

      expect(movieIconFinder, findsOneWidget);

      await widgetTester.tap(movieIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(HomeMoviePage), findsOneWidget);
    },
  );

  testWidgets(
    'Page should navigate to search tv page when search icon is tapped',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(TvEmpty());
      when(() => mockPopularTvBloc.state).thenReturn(TvEmpty());
      when(() => mockTopRatedTvBloc.state).thenReturn(TvEmpty());
      when(() => mockSearchTvBloc.state).thenReturn(SearchTvEmpty());

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      final searchIconFinder = find.byIcon(Icons.search);
      final backIconFinder = find.byIcon(Icons.arrow_back);

      expect(searchIconFinder, findsOneWidget);

      await widgetTester.tap(searchIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(TvSearchPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(HomeTvPage), findsOneWidget);
    },
  );

  testWidgets(
    'Page should be able to navigate to now playing tv page, popular tv page, and top rated tv page',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(TvEmpty());
      when(() => mockPopularTvBloc.state).thenReturn(TvEmpty());
      when(() => mockTopRatedTvBloc.state).thenReturn(TvEmpty());

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      final nowPlayingTvPageKey = find.byKey(ValueKey('now_playing_tv'));
      final popularTvPageKey = find.byKey(ValueKey('popular_tv'));
      final topRatedTvPageKey = find.byKey(ValueKey('top_rated_tv'));
      final backIconFinder = find.byIcon(Icons.arrow_back);

      expect(nowPlayingTvPageKey, findsOneWidget);

      await widgetTester.tap(nowPlayingTvPageKey);
      await widgetTester.pumpAndSettle();

      expect(find.byType(NowPlayingTvPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(popularTvPageKey, findsOneWidget);

      await widgetTester.tap(popularTvPageKey);
      await widgetTester.pumpAndSettle();

      expect(find.byType(PopularTvPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(topRatedTvPageKey, findsOneWidget);

      await widgetTester.tap(topRatedTvPageKey);
      await widgetTester.pumpAndSettle();

      expect(find.byType(TopRatedTvPage), findsOneWidget);

      expect(backIconFinder, findsOneWidget);

      await widgetTester.tap(backIconFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(HomeTvPage), findsOneWidget);
    },
  );
}
