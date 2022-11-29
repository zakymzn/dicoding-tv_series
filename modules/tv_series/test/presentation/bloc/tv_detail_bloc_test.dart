import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_detail_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';

@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(
    () {
      mockGetTvDetail = MockGetTvDetail();
      tvDetailBloc = TvDetailBloc(mockGetTvDetail);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(tvDetailBloc.state, TvEmpty());
    },
  );

  blocTest<TvDetailBloc, TvState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTvDetail.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => const Right(testTvDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvDetail(testTvDetail.id)),
    expect: () => <TvState>[
      TvLoading(),
      const TvDetailHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(testTvDetail.id));
    },
  );

  blocTest<TvDetailBloc, TvState>(
    'emits [Loading, Error] when get tv detail is unsuccessful.',
    build: () {
      when(mockGetTvDetail.execute(testTvDetail.id)).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(OnTvDetail(testTvDetail.id)),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(testTvDetail.id));
    },
  );
}
