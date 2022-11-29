import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_episode_detail_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';

@GenerateMocks([GetTvEpisodeDetail])
void main() {
  late TvEpisodeDetailBloc tvEpisodeDetailBloc;
  late MockGetTvEpisodeDetail mockGetTvEpisodeDetail;

  setUp(
    () {
      mockGetTvEpisodeDetail = MockGetTvEpisodeDetail();
      tvEpisodeDetailBloc = TvEpisodeDetailBloc(mockGetTvEpisodeDetail);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(tvEpisodeDetailBloc.state, TvEmpty());
    },
  );

  blocTest<TvEpisodeDetailBloc, TvState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTvEpisodeDetail.execute(
              testTvDetail.id,
              testTvSeasonDetail.seasonNumber,
              testTvEpisodeDetail.episodeNumber))
          .thenAnswer((realInvocation) async => Right(testTvEpisodeDetail));
      return tvEpisodeDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvEpisodeDetail(testTvDetail.id,
        testTvSeasonDetail.seasonNumber, testTvEpisodeDetail.episodeNumber)),
    expect: () => <TvState>[
      TvLoading(),
      TvEpisodeDetailHasData(testTvEpisodeDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvEpisodeDetail.execute(testTvDetail.id,
          testTvSeasonDetail.seasonNumber, testTvEpisodeDetail.episodeNumber));
    },
  );

  blocTest<TvEpisodeDetailBloc, TvState>(
    'emits [Loading, Error] when get tv episode detail in unsuccessful.',
    build: () {
      when(mockGetTvEpisodeDetail.execute(
              testTvDetail.id,
              testTvSeasonDetail.seasonNumber,
              testTvEpisodeDetail.episodeNumber))
          .thenAnswer((realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return tvEpisodeDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvEpisodeDetail(testTvDetail.id,
        testTvSeasonDetail.seasonNumber, testTvEpisodeDetail.episodeNumber)),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvEpisodeDetail.execute(testTvDetail.id,
          testTvSeasonDetail.seasonNumber, testTvEpisodeDetail.episodeNumber));
    },
  );
}
