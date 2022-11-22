import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'top_rated_tv_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(
    () {
      mockGetTopRatedTv = MockGetTopRatedTv();
      topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(topRatedTvBloc.state, TvEmpty());
    },
  );

  blocTest<TopRatedTvBloc, TvState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((realInvocation) async => Right(testTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTv()),
    expect: () => <TvState>[
      TvLoading(),
      TvListHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );

  blocTest<TopRatedTvBloc, TvState>(
    'emits [Loading, Error] when get top rated tv is unsuccessful.',
    build: () {
      when(mockGetTopRatedTv.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTv()),
    expect: () => <TvState>[
      TvLoading(),
      TvListHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
    },
  );
}
