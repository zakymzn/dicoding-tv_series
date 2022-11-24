import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/movie_bloc_test_helper.dart';
import '../../dummy_data/movie_dummy_objects.dart';

void main() {
  late MockNowPlayingMoviesBloc mockNowPlayingMoviesBloc;
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  setUp(
    () {
      mockNowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
      mockPopularMoviesBloc = MockPopularMoviesBloc();
      mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
      registerFallbackValue(FakeMovieEvent());
      registerFallbackValue(FakeMovieState());
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
      ],
      child: MaterialApp(
        home: body,
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

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final movieItemFinder = find.byKey(ValueKey('movie_$index'));
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
}
