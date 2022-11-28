import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FakeTvState extends Fake implements TvState {}

class FakeTvEvent extends Fake implements TvEvent {}

class MockTvSeasonDetailBloc extends MockBloc<TvEvent, TvState>
    implements TvSeasonDetailBloc {}

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
        onGenerateRoute: routeSettings(),
      ),
    );
  }

  final testTvDetail = TvDetail(
    backdropPath: "backdropPath",
    lastEpisodeToAir: LastEpisodeToAirModel(
      airDate: "airDate",
      episodeNumber: 1,
      id: 1,
      name: "name",
      overview: "overview",
      runtime: 1,
      seasonNumber: 1,
      voteAverage: 1,
      voteCount: 1,
      productionCode: 'productionCode',
      stillPath: 'stillPath',
    ),
    name: "name",
    episodeRunTime: [1],
    firstAirDate: "firstAirDate",
    nextEpisodeToAir: 1,
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ["originCountry"],
    genres: [
      Genre(id: 1, name: "name"),
    ],
    seasons: [
      SeasonModel(
          airDate: "airDate",
          episodeCount: 1,
          id: 1,
          name: "name",
          overview: "overview",
          posterPath: "posterPath",
          seasonNumber: 1)
    ],
    id: 1,
    originalName: "originalName",
    overview: "overview",
    posterPath: "posterPath",
    voteAverage: 1,
    voteCount: 1,
  );

  final testTvSeasonDetail = TvSeasonDetail(
    id: 'id',
    airDate: 'airDate',
    episodes: [
      EpisodeModel(
          airDate: 'airDate',
          episodeNumber: 1,
          crew: [
            CrewInSeasonDetailModel(
              department: 'department',
              job: 'job',
              creditId: 'creditId',
              adult: false,
              gender: 1,
              id: 1,
              knownForDepartment: 'knownForDepartment',
              name: 'name',
              originalName: 'originalName',
              popularity: 1,
              profilePath: 'profilePath',
              order: 1,
              character: 'character',
            ),
          ],
          guestStars: [
            CrewInSeasonDetailModel(
              department: 'department',
              job: 'job',
              creditId: 'creditId',
              adult: false,
              gender: 1,
              id: 1,
              knownForDepartment: 'knownForDepartment',
              name: 'name',
              originalName: 'originalName',
              popularity: 1,
              profilePath: 'profilePath',
              order: 1,
              character: 'character',
            ),
          ],
          id: 1,
          name: 'name',
          overview: 'overview',
          productionCode: 'productionCode',
          seasonNumber: 1,
          stillPath: 'stillPath',
          voteAverage: 1,
          voteCount: 1)
    ],
    name: 'name',
    overview: 'overview',
    seasonDetailId: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  testWidgets(
    'test text style',
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
}
