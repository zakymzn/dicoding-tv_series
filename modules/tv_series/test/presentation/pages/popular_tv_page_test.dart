import 'package:tv_series/tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(TvLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(TvListHasData(testTvList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (WidgetTester tester) async {
      when(() => mockPopularTvBloc.state).thenReturn(TvError('error message'));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets('Page should be scrollable until a tv item is found',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state).thenReturn(TvListHasData(testTvList));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable);
    final tvItemFinder = find.byKey(ValueKey('tv_$index'));

    await tester.scrollUntilVisible(tvItemFinder, 500,
        scrollable: scrollableFinder);

    expect(tvItemFinder, findsOneWidget);
  });
}
