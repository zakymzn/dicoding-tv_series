import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/movie_bloc_test_helper.dart';
import '../../dummy_data/movie_dummy_objects.dart';

void main() {
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(
    () {
      mockMovieWatchlistBloc = MockMovieWatchlistBloc();
      registerFallbackValue(FakeMovieEvent());
      registerFallbackValue(FakeMovieState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieWatchlistBloc>.value(
      value: mockMovieWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress indicator when loading',
    (widgetTester) async {
      when(() => mockMovieWatchlistBloc.state).thenReturn(MovieLoading());

      final progressIndicator = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await widgetTester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressIndicator, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (widgetTester) async {
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieListHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await widgetTester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (widgetTester) async {
      when(() => mockMovieWatchlistBloc.state).thenReturn(MovieError('Failed'));

      final errorFinder = find.byKey(Key('error_message'));

      await widgetTester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(errorFinder, findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );

  testWidgets(
    'Page should be scrollable until a movie item is found',
    (widgetTester) async {
      when(() => mockMovieWatchlistBloc.state)
          .thenReturn(MovieListHasData(testMovieList));

      await widgetTester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final movieItemFinder = find.byKey(ValueKey('movie_$index'));

      await widgetTester.scrollUntilVisible(movieItemFinder, 500,
          scrollable: scrollableFinder);

      expect(movieItemFinder, findsOneWidget);
    },
  );
}
