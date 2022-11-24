import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUp(
    () {
      mockTvWatchlistBloc = MockTvWatchlistBloc();
      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvWatchlistBloc>.value(
      value: mockTvWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress indicator when loading',
    (widgetTester) async {
      when(() => mockTvWatchlistBloc.state).thenReturn(TvLoading());

      final progressIndicator = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await widgetTester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

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

      await widgetTester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (widgetTester) async {
      when(() => mockTvWatchlistBloc.state).thenReturn(TvError('Failed'));

      final errorFinder = find.byKey(Key('error_message'));

      await widgetTester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

      expect(errorFinder, findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );

  testWidgets(
    'Page should be scrollable until a Tv item is found',
    (widgetTester) async {
      when(() => mockTvWatchlistBloc.state)
          .thenReturn(TvListHasData(testTvList));

      await widgetTester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final tvItemFinder = find.byKey(ValueKey('tv_$index'));

      await widgetTester.scrollUntilVisible(tvItemFinder, 500,
          scrollable: scrollableFinder);

      expect(tvItemFinder, findsOneWidget);
    },
  );
}
