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

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
    registerFallbackValue(FakeTvEvent());
    registerFallbackValue(FakeTvState());
  });

  Widget _makeTestableWidget(Widget body) {
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
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvListHasData(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
    'Watchlist button should display check icon when tv is added to watchlist',
    (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(true));

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester
          .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist',
    (WidgetTester tester) async {
      when(() => mockTvDetailBloc.state)
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(TvWatchlistStatus(false));
      when(() => mockTvWatchlistBloc.state).thenReturn(
          TvWatchlistMessage(TvWatchlistBloc.watchlistAddSuccessMessage));

      final watchlistButton = find.byKey(ValueKey('tv_watchlist_button'));

      await tester
          .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

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
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(TvWatchlistStatus(false));
      when(() => mockTvWatchlistBloc.state).thenReturn(TvError('Failed'));

      final watchlistButton = find.byKey(ValueKey('tv_watchlist_button'));

      await tester
          .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

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
          .thenReturn(TvDetailHasData(testTvDetail));
      when(() => mockTvRecommendationsBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockTvWatchlistBloc.state).thenReturn(
          TvWatchlistMessage(TvWatchlistBloc.watchlistRemoveSuccessMessage));
      when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(true));

      final watchlistButton = find.byKey(ValueKey('tv_watchlist_button'));

      await tester
          .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed from Watchlist'), findsOneWidget);
    },
  );

  // testWidgets(
  //   'Watchlist button should display AlertDialog when removed from watchlist failed',
  //   (WidgetTester tester) async {
  //     when(() => mockTvDetailBloc.state)
  //         .thenReturn(TvDetailHasData(testTvDetail));
  //     when(() => mockTvRecommendationsBloc.state)
  //         .thenReturn(TvListHasData(testTvList));
  //     when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(true));
  //     when(() => mockTvWatchlistBloc.state).thenReturn(TvError('Failed'));

  //     final watchlistButton = find.byKey(ValueKey('tv_watchlist_button'));

  //     await tester
  //         .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

  //     expect(find.byIcon(Icons.check), findsOneWidget);

  //     await tester.tap(watchlistButton);
  //     await tester.pump();

  //     expect(find.byType(AlertDialog), findsOneWidget);
  //     expect(find.text('Failed'), findsOneWidget);
  //   },
  // );

  testWidgets(
      'Detail page should show a Circular Progress Indicator when Request State is loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(TvLoading());

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Detail page should show message when Request State is error',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(TvError('Failed'));

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Recommendations should show a Circular Progress Indicator when Request State is loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state).thenReturn(TvLoading());
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Recommendations should show message when Request State is error',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state).thenReturn(TvError('Failed'));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(Text), findsWidgets);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Recommendations should show Container when Request State is empty',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state).thenReturn(TvEmpty());
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    expect(find.byType(Container), findsWidgets);
  });

  testWidgets(
      'Recommendations should be scrollable until a recommended tv item is found',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvListHasData(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));

    await tester
        .pumpWidget(_makeTestableWidget(TvDetailPage(id: testTvDetail.id)));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable).first;
    final recommendationFinder = find.byKey(ValueKey('recommendation_$index'));

    await tester.scrollUntilVisible(recommendationFinder, 500,
        scrollable: scrollableFinder);

    expect(recommendationFinder, findsOneWidget);
  });
}
