import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/tv_bloc_test_helper.dart';
import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  late MockTvEpisodeDetailBloc mockTvEpisodeDetailBloc;

  setUp(
    () {
      mockTvEpisodeDetailBloc = MockTvEpisodeDetailBloc();
      registerFallbackValue(FakeTvEvent());
      registerFallbackValue(FakeTvState());
    },
  );

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvEpisodeDetailBloc>.value(
      value: mockTvEpisodeDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Guest Stars expansion panel should show a grid view list of guest stars and scrollable until a guest star item is found',
    (widgetTester) async {
      when(() => mockTvEpisodeDetailBloc.state)
          .thenReturn(TvEpisodeDetailHasData(testTvEpisodeDetail));

      await widgetTester.pumpWidget(makeTestableWidget(TvEpisodeDetailPage(
          id: testTvDetail.id,
          seasonNumber: testTvSeasonDetail.seasonNumber,
          episodeNumber: testTvEpisodeDetail.episodeNumber)));

      expect(find.text('Guest Stars'), findsOneWidget);

      await widgetTester.tap(find.text('Guest Stars'));

      expect(find.byType(MasonryGridView), findsWidgets);

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final guestStarFinder = find.byKey(ValueKey('guest_star_$index'));

      await widgetTester.scrollUntilVisible(guestStarFinder, 500,
          scrollable: scrollableFinder.first);

      expect(guestStarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Crew expansion panel should show a grid view list of crew and scrollable until crew item is found',
    (widgetTester) async {
      when(() => mockTvEpisodeDetailBloc.state)
          .thenReturn(TvEpisodeDetailHasData(testTvEpisodeDetail));

      await widgetTester.pumpWidget(makeTestableWidget(TvEpisodeDetailPage(
          id: testTvDetail.id,
          seasonNumber: testTvSeasonDetail.seasonNumber,
          episodeNumber: testTvEpisodeDetail.episodeNumber)));

      expect(find.text('Crew'), findsOneWidget);

      await widgetTester.tap(find.text('Crew'));

      expect(find.byType(MasonryGridView), findsWidgets);

      int index = 0;
      final scrollableFinder = find.byType(Scrollable);
      final crewFinder = find.byKey(ValueKey('crew_$index'));

      await widgetTester.scrollUntilVisible(crewFinder, 500,
          scrollable: scrollableFinder.first);

      expect(crewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Episode detail page should show a circular progress indicator when request state is loading',
    (widgetTester) async {
      when(() => mockTvEpisodeDetailBloc.state).thenReturn(TvLoading());

      await widgetTester.pumpWidget(makeTestableWidget(TvEpisodeDetailPage(
          id: testTvDetail.id,
          seasonNumber: testTvSeasonDetail.seasonNumber,
          episodeNumber: testTvEpisodeDetail.episodeNumber)));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Episode detail page should show message when request state is error',
    (widgetTester) async {
      when(() => mockTvEpisodeDetailBloc.state)
          .thenReturn(const TvError('Failed'));

      await widgetTester.pumpWidget(makeTestableWidget(TvEpisodeDetailPage(
          id: testTvDetail.id,
          seasonNumber: testTvSeasonDetail.seasonNumber,
          episodeNumber: testTvEpisodeDetail.episodeNumber)));

      expect(find.text('Failed'), findsOneWidget);
    },
  );
}
