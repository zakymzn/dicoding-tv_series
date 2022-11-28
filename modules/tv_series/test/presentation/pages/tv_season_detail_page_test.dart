import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockTvSeasonDetailBloc mockTvSeasonDetailBloc;
  late MockTvEpisodeDetailBloc mockTvEpisodeDetailBloc;

  setUp(
    () {
      mockTvSeasonDetailBloc = MockTvSeasonDetailBloc();
      mockTvEpisodeDetailBloc = MockTvEpisodeDetailBloc();
      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());
    },
  );

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeasonDetailBloc>(
          create: (context) => mockTvSeasonDetailBloc,
        ),
        BlocProvider<TvEpisodeDetailBloc>(
          create: (context) => mockTvEpisodeDetailBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
        onGenerateRoute: routeSettings(),
      ),
    );
  }

  testWidgets(
    'Tv episode list should be scrollable until a tv episode item is found and can be able to navigate to episode detail page',
    (widgetTester) async {
      when(() => mockTvSeasonDetailBloc.state)
          .thenReturn(TvSeasonDetailHasData(testTvSeasonDetail));
      when(() => mockTvEpisodeDetailBloc.state).thenReturn(TvEmpty());

      await widgetTester.pumpWidget(_makeTestableWidget(TvSeasonDetailPage(
          id: testTvDetail.id, seasonNumber: testTvSeasonDetail.seasonNumber)));

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final episodeFinder = find.byKey(ValueKey('tv_episode_$index'));

      await widgetTester.scrollUntilVisible(episodeFinder, 500,
          scrollable: scrollableFinder.first);

      expect(episodeFinder, findsOneWidget);

      await widgetTester.tap(episodeFinder);
      await widgetTester.pump();
      await widgetTester.pumpAndSettle();

      expect(find.byType(TvEpisodeDetailPage), findsOneWidget);
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
