import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockTvWatchlistBloc mockTvWatchlistBloc;
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;

  setUp(
    () {
      mockTvWatchlistBloc = MockTvWatchlistBloc();
      mockTvDetailBloc = MockTvDetailBloc();
      mockTvRecommendationsBloc = MockTvRecommendationsBloc();
      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());
    },
  );

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvWatchlistBloc>(
          create: (context) => mockTvWatchlistBloc,
        ),
        BlocProvider<TvDetailBloc>(
          create: (context) => mockTvDetailBloc,
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
    'Page should display center progress indicator when loading',
    (widgetTester) async {
      when(() => mockTvWatchlistBloc.state).thenReturn(TvLoading());

      final progressIndicator = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await widgetTester
          .pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressIndicator, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (widgetTester) async {
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(TvListHasData(testTvList));

      final listViewFinder = find.byType(ListView);

      await widgetTester
          .pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (widgetTester) async {
      when(() => mockTvWatchlistBloc.state).thenReturn(const TvError('Failed'));

      final errorFinder = find.byKey(const Key('error_message'));

      await widgetTester
          .pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(errorFinder, findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );

  testWidgets(
    'Page should be scrollable until a Tv item is found',
    (widgetTester) async {
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockTvDetailBloc.state).thenReturn(TvEmpty());
      when(() => mockTvRecommendationsBloc.state).thenReturn(TvEmpty());

      await widgetTester
          .pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final tvItemFinder = find.byKey(ValueKey('tv_$index'));

      await widgetTester.scrollUntilVisible(tvItemFinder, 500,
          scrollable: scrollableFinder);

      expect(tvItemFinder, findsOneWidget);

      await widgetTester.tap(tvItemFinder);
      await widgetTester.pumpAndSettle();

      expect(find.byType(TvDetailPage), findsOneWidget);
    },
  );
}
