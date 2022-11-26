import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockTvSeasonDetailBloc mockTvSeasonDetailBloc;

  setUp(
    () {
      mockTvSeasonDetailBloc = MockTvSeasonDetailBloc();
      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSeasonDetailBloc>.value(
      value: mockTvSeasonDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Tv episode list should be scrollable until a tv episode item is found',
    (widgetTester) async {
      when(() => mockTvSeasonDetailBloc.state)
          .thenReturn(TvSeasonDetailHasData(testTvSeasonDetail));

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
          id: testTvDetail.id, seasonNumber: testTvSeasonDetail.seasonNumber)));

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final episodeFinder = find.byKey(ValueKey('tv_episode_$index'));

      await widgetTester.scrollUntilVisible(episodeFinder, 500,
          scrollable: scrollableFinder.first);

      expect(episodeFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Season detail page should show a circular progress indicator when request state is loading',
    (widgetTester) async {
      when(() => mockTvSeasonDetailBloc.state).thenReturn(TvLoading());

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
          id: testTvDetail.id, seasonNumber: testTvSeasonDetail.seasonNumber)));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Season detail page should show message when request state is error',
    (widgetTester) async {
      when(() => mockTvSeasonDetailBloc.state).thenReturn(TvError('Failed'));

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
          id: testTvDetail.id, seasonNumber: testTvSeasonDetail.seasonNumber)));

      expect(find.text('Failed'), findsOneWidget);
    },
  );
}
