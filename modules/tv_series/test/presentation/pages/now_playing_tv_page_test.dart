import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockNowPlayingTvBloc mockNowPlayingTvBloc;
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(() {
    mockNowPlayingTvBloc = MockNowPlayingTvBloc();
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
    registerFallbackValue(FakeTvEvent());
    registerFallbackValue(FakeTvState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvBloc>(
          create: (context) => mockNowPlayingTvBloc,
        ),
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
        onGenerateRoute: routeSettings(),
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (WidgetTester tester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(TvLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(() => mockNowPlayingTvBloc.state)
          .thenReturn(TvListHasData(testTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (WidgetTester tester) async {
      when(() => mockNowPlayingTvBloc.state)
          .thenReturn(TvError('error message'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets('Page should be scrollable until a tv item is found',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvBloc.state)
        .thenReturn(TvListHasData(testTvList));
    when(() => mockTvDetailBloc.state).thenReturn(TvEmpty());
    when(() => mockTvRecommendationsBloc.state).thenReturn(TvEmpty());
    when(() => mockTvWatchlistBloc.state).thenReturn(TvEmpty());

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable);
    final tvItemFinder = find.byKey(ValueKey('tv_$index'));

    await tester.scrollUntilVisible(tvItemFinder, 500,
        scrollable: scrollableFinder);

    expect(tvItemFinder, findsOneWidget);

    await tester.tap(tvItemFinder);
    await tester.pumpAndSettle();

    expect(find.byType(TvDetailPage), findsOneWidget);
  });
}
