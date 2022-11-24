import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockNowPlayingTvBloc mockNowPlayingTvBloc;

  setUp(() {
    mockNowPlayingTvBloc = MockNowPlayingTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvBloc>.value(
      value: mockNowPlayingTvBloc,
      child: MaterialApp(
        home: body,
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

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable);
    final tvItemFinder = find.byKey(ValueKey('tv_$index'));

    await tester.scrollUntilVisible(tvItemFinder, 500,
        scrollable: scrollableFinder);

    expect(tvItemFinder, findsOneWidget);
  });
}
