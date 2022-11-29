import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
import 'package:search/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../movies/test/helpers/movie_bloc_test_helper.dart';
import '../../../tv_series/test/helpers/tv_bloc_test_helper.dart';
import '../../../search/test/helpers/search_movie_bloc_test_helper.dart';
import '../../../search/test/helpers/search_tv_bloc_test_helper.dart';
import '../dummy_data/movie_dummy_objects.dart';
import '../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockNowPlayingMoviesBloc mockNowPlayingMoviesBloc;
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  late MockNowPlayingTvBloc mockNowPlayingTvBloc;
  late MockPopularTvBloc mockPopularTvBloc;
  late MockTopRatedTvBloc mockTopRatedTvBloc;
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvSeasonDetailBloc mockTvSeasonDetailBloc;
  late MockTvEpisodeDetailBloc mockTvEpisodeDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  late MockSearchMoviesBloc mockSearchMoviesBloc;
  late MockSearchTvBloc mockSearchTvBloc;

  setUp(
    () {
      mockNowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
      mockPopularMoviesBloc = MockPopularMoviesBloc();
      mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
      mockMovieDetailBloc = MockMovieDetailBloc();
      mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();
      mockMovieWatchlistBloc = MockMovieWatchlistBloc();

      mockNowPlayingTvBloc = MockNowPlayingTvBloc();
      mockPopularTvBloc = MockPopularTvBloc();
      mockTopRatedTvBloc = MockTopRatedTvBloc();
      mockTvDetailBloc = MockTvDetailBloc();
      mockTvSeasonDetailBloc = MockTvSeasonDetailBloc();
      mockTvEpisodeDetailBloc = MockTvEpisodeDetailBloc();
      mockTvRecommendationsBloc = MockTvRecommendationsBloc();
      mockTvWatchlistBloc = MockTvWatchlistBloc();

      mockSearchMoviesBloc = MockSearchMoviesBloc();
      mockSearchTvBloc = MockSearchTvBloc();

      registerFallbackValue(FakeMovieEvent());
      registerFallbackValue(FakeMovieState());

      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());

      registerFallbackValue(FakeSearchMoviesEvent());
      registerFallbackValue(FakeSearchMoviesState());
    },
  );

  Widget makeTestableWidget(Widget body) {
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
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieRecommendationsBloc>(
          create: (context) => mockMovieRecommendationsBloc,
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
        BlocProvider<TvDetailBloc>(
          create: (context) => mockTvDetailBloc,
        ),
        BlocProvider<TvSeasonDetailBloc>(
          create: (context) => mockTvSeasonDetailBloc,
        ),
        BlocProvider<TvEpisodeDetailBloc>(
          create: (context) => mockTvEpisodeDetailBloc,
        ),
        BlocProvider<TvRecommendationsBloc>(
          create: (context) => mockTvRecommendationsBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => mockTvWatchlistBloc,
        ),
        BlocProvider<SearchMoviesBloc>(
          create: (context) => mockSearchMoviesBloc,
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

  group(
    'Movies navigation test',
    () {
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

          await widgetTester
              .pumpWidget(makeTestableWidget(const HomeMoviePage()));

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
          when(() => mockSearchMoviesBloc.state)
              .thenReturn(SearchMoviesEmpty());

          await widgetTester
              .pumpWidget(makeTestableWidget(const HomeMoviePage()));

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

          await widgetTester
              .pumpWidget(makeTestableWidget(const HomeMoviePage()));

          final nowPlayingMoviesPageKey =
              find.byKey(const ValueKey('now_playing_movies'));
          final popularMoviesPageKey =
              find.byKey(const ValueKey('popular_movies'));
          final topRatedMoviesPageKey =
              find.byKey(const ValueKey('top_rated_movies'));
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

      testWidgets(
          'Recommendations should be scrollable until a recommended movie item is found and navigate to another movie detail page',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state)
            .thenReturn(const MovieDetailHasData(testMovieDetail));
        when(() => mockMovieRecommendationsBloc.state)
            .thenReturn(MovieListHasData(testMovieList));
        when(() => mockMovieWatchlistBloc.state)
            .thenReturn(const MovieWatchlistStatus(false));

        await tester.pumpWidget(
            makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

        int index = 0;
        final scrollableFinder = find.byType(Scrollable).first;
        final recommendationFinder =
            find.byKey(ValueKey('recommendation_$index'));

        final backIconFinder = find.byIcon(Icons.arrow_back);

        await tester.scrollUntilVisible(recommendationFinder, 500,
            scrollable: scrollableFinder);

        expect(recommendationFinder, findsOneWidget);

        await tester.tap(recommendationFinder);
        await tester.pump();

        expect(find.byType(MovieDetailPage), findsOneWidget);

        expect(backIconFinder, findsOneWidget);

        await tester.tap(backIconFinder, warnIfMissed: false);
        await tester.pump();
      });
    },
  );

  group(
    'Tv series navigation test',
    () {
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

          await widgetTester.pumpWidget(makeTestableWidget(const HomeTvPage()));

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

          await widgetTester.pumpWidget(makeTestableWidget(const HomeTvPage()));

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

          await widgetTester.pumpWidget(makeTestableWidget(const HomeTvPage()));

          final nowPlayingTvPageKey =
              find.byKey(const ValueKey('now_playing_tv'));
          final popularTvPageKey = find.byKey(const ValueKey('popular_tv'));
          final topRatedTvPageKey = find.byKey(const ValueKey('top_rated_tv'));
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
      testWidgets(
        'Season list should be scrollable and can be able to navigate to tv season detail page',
        (WidgetTester tester) async {
          when(() => mockTvDetailBloc.state)
              .thenReturn(const TvDetailHasData(testTvDetail));
          when(() => mockTvRecommendationsBloc.state)
              .thenReturn(TvListHasData(testTvList));
          when(() => mockTvWatchlistBloc.state)
              .thenReturn(const TvWatchlistStatus(false));
          when(() => mockTvSeasonDetailBloc.state).thenReturn(TvEmpty());

          await tester.pumpWidget(
              makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

          int index = 0;
          final scrollableFinder = find.byType(Scrollable);
          final seasonFinder = find.byKey(ValueKey('season_$index'));
          final backIconFinder = find.byIcon(Icons.arrow_back);

          await tester.scrollUntilVisible(seasonFinder, 500,
              scrollable: scrollableFinder.first);

          expect(seasonFinder, findsOneWidget);

          await tester.tap(seasonFinder);
          await tester.pumpAndSettle();

          expect(find.byType(TvSeasonDetailPage), findsOneWidget);

          expect(backIconFinder, findsOneWidget);

          await tester.tap(backIconFinder);
          await tester.pump();

          expect(find.byType(TvDetailPage), findsOneWidget);
        },
      );

      testWidgets(
          'Recommendations should be scrollable until a recommended tv item is found',
          (WidgetTester tester) async {
        when(() => mockTvDetailBloc.state)
            .thenReturn(const TvDetailHasData(testTvDetail));
        when(() => mockTvRecommendationsBloc.state)
            .thenReturn(TvListHasData(testTvList));
        when(() => mockTvWatchlistBloc.state)
            .thenReturn(const TvWatchlistStatus(false));

        await tester
            .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

        int index = 0;
        final scrollableFinder = find.byType(Scrollable).first;
        final recommendationFinder =
            find.byKey(ValueKey('recommendation_$index'));

        final backIconFinder = find.byIcon(Icons.arrow_back);

        await tester.scrollUntilVisible(recommendationFinder, 500,
            scrollable: scrollableFinder);

        expect(recommendationFinder, findsOneWidget);

        await tester.tap(recommendationFinder);
        await tester.pump();

        expect(find.byType(TvDetailPage), findsOneWidget);

        expect(backIconFinder, findsOneWidget);

        await tester.tap(backIconFinder, warnIfMissed: false);
        await tester.pump();
      });

      testWidgets(
        'Tv episode list should be scrollable until a tv episode item is found and can be able to navigate to episode detail page',
        (widgetTester) async {
          when(() => mockTvSeasonDetailBloc.state)
              .thenReturn(TvSeasonDetailHasData(testTvSeasonDetail));
          when(() => mockTvEpisodeDetailBloc.state).thenReturn(TvEmpty());

          await widgetTester.pumpWidget(makeTestableWidget(TvSeasonDetailPage(
              id: testTvDetail.id,
              seasonNumber: testTvSeasonDetail.seasonNumber)));

          int index = 0;
          final scrollableFinder = find.byType(Scrollable);
          final episodeFinder = find.byKey(ValueKey('tv_episode_$index'));

          await widgetTester.scrollUntilVisible(episodeFinder, 500,
              scrollable: scrollableFinder.first);

          expect(episodeFinder, findsOneWidget);

          await widgetTester.tap(episodeFinder);
          await widgetTester.pump();
          await widgetTester.pumpAndSettle();

          expect(find.byType(TvEpisodeDetailPage), findsOneWidget);
        },
      );
    },
  );
}
