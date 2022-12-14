import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/movie_bloc_test_helper.dart';
import '../../dummy_data/movie_dummy_objects.dart';

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
    registerFallbackValue(FakeMovieEvent());
    registerFallbackValue(FakeMovieState());
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
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

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieListHasData(testMovieList));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));
    when(() => mockMovieWatchlistBloc.state).thenReturn(
        const MovieWatchlistMessage(
            MovieWatchlistBloc.watchlistAddSuccessMessage));

    final watchlistButton =
        find.byKey(const ValueKey('movie_watchlist_button'));

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(MovieWatchlistBloc.watchlistAddSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieError('Failed'));

    final watchlistButton =
        find.byKey(const ValueKey('movie_watchlist_button'));

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(MovieListHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state).thenReturn(
        const MovieWatchlistMessage(
            MovieWatchlistBloc.watchlistRemoveSuccessMessage));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(true));

    final watchlistButton =
        find.byKey(const ValueKey('movie_watchlist_button'));

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(MovieWatchlistBloc.watchlistRemoveSuccessMessage),
        findsOneWidget);
  });

  testWidgets(
    'Detail page should show a Circular Progress Indicator when Request State is loading',
    (WidgetTester tester) async {
      when(() => mockMovieDetailBloc.state).thenReturn(MovieLoading());

      await tester.pumpWidget(
          makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets('Detail page should show message when Request State is error',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieError('Failed'));

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Recommendations should show a Circular Progress Indicator when Request State is loading',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state).thenReturn(MovieLoading());
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Recommendations should show message when Request State is error',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state)
        .thenReturn(const MovieError('Failed'));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byType(Text), findsWidgets);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Recommendations should show Container when Request State is empty',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationsBloc.state).thenReturn(MovieEmpty());
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const MovieWatchlistStatus(false));

    await tester.pumpWidget(
        makeTestableWidget(MovieDetailPage(id: testMovieDetail.id)));

    expect(find.byType(Container), findsWidgets);
  });

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
    final recommendationFinder = find.byKey(ValueKey('recommendation_$index'));

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
}
