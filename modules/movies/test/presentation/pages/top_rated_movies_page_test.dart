import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/movie_bloc_test_helper.dart';
import '../../dummy_data/movie_dummy_objects.dart';

void main() {
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  setUp(
    () {
      mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
      registerFallbackValue(FakeMovieEvent());
      registerFallbackValue(FakeMovieState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockTopRatedMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display progress indicator when loading',
    (widgetTester) async {
      when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await widgetTester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state)
        .thenReturn(MovieListHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state)
        .thenReturn(MovieError('error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should be scrollable until a movie item is found',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state)
        .thenReturn(MovieListHasData(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable);
    final movieItemFinder = find.byKey(ValueKey('movie_$index'));

    await tester.scrollUntilVisible(movieItemFinder, 500,
        scrollable: scrollableFinder);

    expect(movieItemFinder, findsOneWidget);
  });
}
