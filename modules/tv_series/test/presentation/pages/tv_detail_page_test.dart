import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;
  late MockTvSeasonDetailBloc mockTvSeasonDetailBloc;

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
    mockTvSeasonDetailBloc = MockTvSeasonDetailBloc();
    registerFallbackValue(FakeTvEvent());
    registerFallbackValue(FakeTvState());
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (context) => mockTvDetailBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => mockTvWatchlistBloc,
        ),
        BlocProvider<TvRecommendationsBloc>(
          create: (context) => mockTvRecommendationsBloc,
        ),
        BlocProvider<TvSeasonDetailBloc>(
          create: (context) => mockTvSeasonDetailBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routeSettings(),
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvListHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
    'Watchlist button should display check icon when tv is added to watchlist',
    (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(const TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(true));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist',
    (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(const TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(false));
      when(() => mockTvWatchlistBloc.state).thenReturn(
          const TvWatchlistMessage(TvWatchlistBloc.watchlistAddSuccessMessage));

      final watchlistButton = find.byKey(const ValueKey('tv_watchlist_button'));

      await tester
          .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(TvWatchlistBloc.watchlistAddSuccessMessage),
          findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when add to watchlist failed',
    (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(const TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(false));
      when(() => mockTvWatchlistBloc.state).thenReturn(const TvError('Failed'));

      final watchlistButton = find.byKey(const ValueKey('tv_watchlist_button'));

      await tester
          .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when removed from watchlist',
    (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(const TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockTvWatchlistBloc.state).thenReturn(const TvWatchlistMessage(
          TvWatchlistBloc.watchlistRemoveSuccessMessage));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(const TvWatchlistStatus(true));

      final watchlistButton = find.byKey(const ValueKey('tv_watchlist_button'));

      await tester
          .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed from Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
      'Detail page should show a Circular Progress Indicator when Request State is loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(TvLoading());

    await tester
        .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Detail page should show message when Request State is error',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(const TvError('Failed'));

    await tester
        .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

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

      await tester
          .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

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
      'Recommendations should show a Circular Progress Indicator when Request State is loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state).thenReturn(TvLoading());
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));

    await tester
        .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Recommendations should show message when Request State is error',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(const TvError('Failed'));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));

    await tester
        .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(Text), findsWidgets);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Recommendations should show Container when Request State is empty',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state).thenReturn(TvEmpty());
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const TvWatchlistStatus(false));

    await tester
        .pumpWidget(makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(Container), findsWidgets);
  });

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
    final recommendationFinder = find.byKey(ValueKey('recommendation_$index'));

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
}
