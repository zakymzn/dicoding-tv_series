import '../../../../lib/utils/state_enum.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:core/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/tv/tv_dummy_objects.dart';
import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TopRatedTvNotifier])
void main() {
  late MockTopRatedTvNotifier mockNotifier;

  setUp(
    () {
      mockNotifier = MockTopRatedTvNotifier();
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display progress bar when loading',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loading);

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
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(<Tv>[]);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('error message');

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets('Page should be scrollable until a movie item is found',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvList);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable);
    final tvItemFinder = find.byKey(ValueKey('tv_$index'));

    await tester.scrollUntilVisible(tvItemFinder, 500,
        scrollable: scrollableFinder);

    expect(tvItemFinder, findsOneWidget);
  });
}
