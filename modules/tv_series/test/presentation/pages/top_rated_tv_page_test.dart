import 'package:tv_series/tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUp(
    () {
      mockTopRatedTvBloc = MockTopRatedTvBloc();
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockTopRatedTvBloc,
      child: MaterialApp(
        home: body,
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

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable);
    final tvItemFinder = find.byKey(ValueKey('tv_$index'));

    await tester.scrollUntilVisible(tvItemFinder, 500,
        scrollable: scrollableFinder);

    expect(tvItemFinder, findsOneWidget);
  });
}
