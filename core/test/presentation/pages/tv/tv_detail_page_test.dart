import '../../../../lib/utils/state_enum.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/presentation/pages/tv/tv_detail_page.dart';
import 'package:core/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/tv/tv_dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
    'Watchlist button should display check icon when tv is added to watchlist',
    (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist',
    (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when add to watchlist failed',
    (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

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
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);
      when(mockNotifier.watchlistMessage).thenReturn('Removed from Watchlist');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed from Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when removed from watchlist failed',
    (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );

  testWidgets(
      'Detail page should show a Circular Progress Indicator when Request State is loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loading);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Detail page should show message when Request State is error',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Failed to connect to the network');

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('Failed to connect to the network'), findsOneWidget);
  });

  testWidgets(
      'Recommendations should show a Circular Progress Indicator when Request State is loading',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loading);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsWidgets);
  });

  testWidgets('Recommendations should show message when Request State is error',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.error);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.message).thenReturn('Failed');

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(Text), findsWidgets);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      'Recommendations should show Container when Request State is empty',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.empty);
    when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(Container), findsWidgets);
  });

  testWidgets(
      'Recommendations should be scrollable until a recommended tv item is found',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.loaded);
    when(mockNotifier.tv).thenReturn(testTvDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.tvRecommendations).thenReturn(testTvList);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    int index = 0;
    final scrollableFinder = find.byType(Scrollable).first;
    final recommendationFinder = find.byKey(ValueKey('recommendation_$index'));

    await tester.scrollUntilVisible(recommendationFinder, 500,
        scrollable: scrollableFinder);

    expect(recommendationFinder, findsOneWidget);
  });
}