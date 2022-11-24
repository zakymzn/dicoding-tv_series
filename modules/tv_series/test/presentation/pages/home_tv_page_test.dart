import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockNowPlayingTvBloc mockNowPlayingTvBloc;
  late MockPopularTvBloc mockPopularTvBloc;
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUp(
    () {
      mockNowPlayingTvBloc = MockNowPlayingTvBloc();
      mockPopularTvBloc = MockPopularTvBloc();
      mockTopRatedTvBloc = MockTopRatedTvBloc();
      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvBloc>(
          create: (context) => mockNowPlayingTvBloc,
        ),
        BlocProvider<PopularTvBloc>(
          create: (context) => mockPopularTvBloc,
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (context) => mockTopRatedTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress indicator when loading',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(TvLoading());
      when(() => mockPopularTvBloc.state).thenReturn(TvLoading());
      when(() => mockTopRatedTvBloc.state).thenReturn(TvLoading());

      final progressIndicatorFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(centerFinder, findsWidgets);
      expect(progressIndicatorFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockPopularTvBloc.state).thenReturn(TvListHasData(testTvList));
      when(() => mockTopRatedTvBloc.state)
          .thenReturn(TvListHasData(testTvList));

      final listViewFinder = find.byType(ListView);

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(listViewFinder, findsWidgets);
    },
  );

  testWidgets(
    'Page should display text with message when error',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state).thenReturn(TvError('Failed'));
      when(() => mockPopularTvBloc.state).thenReturn(TvError('Failed'));
      when(() => mockTopRatedTvBloc.state).thenReturn(TvError('Failed'));

      final textFinder = find.byType(Text);

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(textFinder, findsWidgets);
      expect(find.text('Failed'), findsWidgets);
    },
  );

  testWidgets(
    'Page should be scrollable',
    (widgetTester) async {
      when(() => mockNowPlayingTvBloc.state)
          .thenReturn(TvListHasData(testTvList));
      when(() => mockPopularTvBloc.state).thenReturn(TvListHasData(testTvList));
      when(() => mockTopRatedTvBloc.state)
          .thenReturn(TvListHasData(testTvList));

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final tvItemFinder = find.byKey(ValueKey('tv_$index'));
      final nowPlayingTvFinder = find.byKey(ValueKey('now_playing_tv'));
      final popularTvFinder = find.byKey(ValueKey('popular_tv'));
      final topRatedTvFinder = find.byKey(ValueKey('top_rated_tv'));

      await widgetTester.pumpWidget(_makeTestableWidget(HomeTvPage()));
      await widgetTester.scrollUntilVisible(nowPlayingTvFinder, 500,
          scrollable: scrollableFinder.first);
      expect(nowPlayingTvFinder, findsOneWidget);

      await widgetTester.scrollUntilVisible(popularTvFinder, 500,
          scrollable: scrollableFinder.first);
      expect(popularTvFinder, findsOneWidget);

      await widgetTester.scrollUntilVisible(topRatedTvFinder, 500,
          scrollable: scrollableFinder.first);
      expect(topRatedTvFinder, findsOneWidget);
    },
  );
}
