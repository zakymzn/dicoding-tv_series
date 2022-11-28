import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(
    () {
      mockTopRatedTvBloc = MockTopRatedTvBloc();
      mockTvDetailBloc = MockTvDetailBloc();
      mockTvRecommendationsBloc = MockTvRecommendationsBloc();
      mockTvWatchlistBloc = MockTvWatchlistBloc();
      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopRatedTvBloc>(
          create: (context) => mockTopRatedTvBloc,
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
    'Page should display progress bar when loading',
    (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state).thenReturn(TvLoading());

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display when data is loaded',
    (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state)
          .thenReturn(TvListHasData(testTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (WidgetTester tester) async {
      when(() => mockTopRatedTvBloc.state).thenReturn(TvError('error message'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets('Page should be scrollable until a movie item is found',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state).thenReturn(TvListHasData(testTvList));
    when(() => mockTvDetailBloc.state).thenReturn(TvEmpty());
    when(() => mockTvRecommendationsBloc.state).thenReturn(TvEmpty());
    when(() => mockTvWatchlistBloc.state).thenReturn(TvEmpty());

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

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
