import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/movie_bloc_test_helper.dart';
import '../../dummy_data/movie_dummy_objects.dart';

void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
    registerFallbackValue(FakeMovieEvent());
    registerFallbackValue(FakeMovieState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>(
          create: (context) => mockPopularMoviesBloc,
        ),
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockMovieWatchlistBloc,
        ),
        BlocProvider<MovieRecommendationsBloc>(
          create: (context) => mockMovieRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routeSettings(),
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
    when(() => mockMovieDetailBloc.state).thenReturn(MovieEmpty());
    when(() => mockMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockMovieWatchlistBloc.state).thenReturn(MovieEmpty());

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable);
    final movieItemFinder = find.byKey(ValueKey('movie_$index'));

    await tester.scrollUntilVisible(movieItemFinder, 500,
        scrollable: scrollableFinder);

    expect(movieItemFinder, findsOneWidget);

    await tester.tap(movieItemFinder);
    await tester.pumpAndSettle();

    expect(find.byType(MovieDetailPage), findsOneWidget);
  });
}
