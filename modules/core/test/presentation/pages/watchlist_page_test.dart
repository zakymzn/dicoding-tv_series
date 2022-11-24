import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../movies/test/helpers/movie_bloc_test_helper.dart';
import '../../../../movies/test/dummy_data/movie_dummy_objects.dart';
import '../../../../tv_series/test/helpers/tv_bloc_test_helper.dart';
import '../../../../tv_series/test/dummy_data/tv_dummy_objects.dart';

void main() {
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(
    () {
      mockMovieWatchlistBloc = MockMovieWatchlistBloc();
      mockTvWatchlistBloc = MockTvWatchlistBloc();
      registerFallbackValue(FakeMovieEvent());
      registerFallbackValue(FakeMovieState());
      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockMovieWatchlistBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => mockTvWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display watchlist movies page',
    (widgetTester) async {
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieListHasData(testMovieList));

      final iconFinder = find.byIcon(Icons.movie);
      final pageFinder = find.byType(WatchlistMoviesPage);

      await widgetTester.pumpWidget(_makeTestableWidget(WatchListPage()));

      expect(iconFinder, findsOneWidget);

      await widgetTester.tap(iconFinder);
      await widgetTester.pump();

      expect(pageFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display watchlist tv page',
    (widgetTester) async {
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieListHasData(testMovieList));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(TvListHasData(testTvList));

      final iconFinder = find.byIcon(Icons.tv);
      final pageFinder = find.byType(WatchlistTvPage);

      await widgetTester.pumpWidget(_makeTestableWidget(WatchListPage()));

      expect(find.byType(TabBar), findsOneWidget);

      await widgetTester.tap(iconFinder);
      await widgetTester.pump();

      expect(pageFinder, findsOneWidget);
    },
  );
}
