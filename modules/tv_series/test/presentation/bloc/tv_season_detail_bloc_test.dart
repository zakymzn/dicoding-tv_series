import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_season_detail_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late TvSeasonDetailBloc tvSeasonDetailBloc;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;

  setUp(
    () {
      mockGetTvSeasonDetail = MockGetTvSeasonDetail();
      tvSeasonDetailBloc = TvSeasonDetailBloc(mockGetTvSeasonDetail);
    },
  );

  test(
    'inital state should be empty',
    () {
      expect(tvSeasonDetailBloc.state, TvEmpty());
    },
  );

  blocTest<TvSeasonDetailBloc, TvState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTvSeasonDetail.execute(
              testTvDetail.id, testTvSeasonDetail.seasonNumber))
          .thenAnswer((realInvocation) async => Right(testTvSeasonDetail));
      return tvSeasonDetailBloc;
    },
    act: (bloc) => bloc.add(
        OnTvSeasonDetail(testTvDetail.id, testTvSeasonDetail.seasonNumber)),
    expect: () => <TvState>[
      TvLoading(),
      TvSeasonDetailHasData(testTvSeasonDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvSeasonDetail.execute(
          testTvDetail.id, testTvSeasonDetail.seasonNumber));
    },
  );

  blocTest<TvSeasonDetailBloc, TvState>(
    'emits [Loading, Error] when get tv season detail is unsuccessful.',
    build: () {
      when(mockGetTvSeasonDetail.execute(
              testTvDetail.id, testTvSeasonDetail.seasonNumber))
          .thenAnswer((realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return tvSeasonDetailBloc;
    },
    act: (bloc) => bloc.add(
        OnTvSeasonDetail(testTvDetail.id, testTvSeasonDetail.seasonNumber)),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeasonDetail.execute(
          testTvDetail.id, testTvSeasonDetail.seasonNumber));
    },
  );
}
