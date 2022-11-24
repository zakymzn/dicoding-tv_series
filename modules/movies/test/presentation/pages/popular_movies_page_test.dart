import 'package:movies/movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/movie_bloc_test_helper.dart';
import '../../dummy_data/movie_dummy_objects.dart';

void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockPopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state).thenReturn(MovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state)
        .thenReturn(MovieListHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state)
        .thenReturn(MovieError('error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should be scrollable until a movie item is found',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state)
        .thenReturn(MovieListHasData(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable);
    final movieItemFinder = find.byKey(ValueKey('movie_$index'));

    await tester.scrollUntilVisible(movieItemFinder, 500,
        scrollable: scrollableFinder);

    expect(movieItemFinder, findsOneWidget);
  });
}
