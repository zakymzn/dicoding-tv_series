import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'popular_tv_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(
    () {
      mockGetPopularTv = MockGetPopularTv();
      popularTvBloc = PopularTvBloc(mockGetPopularTv);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(popularTvBloc.state, TvEmpty());
    },
  );

  blocTest<PopularTvBloc, TvState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((realInvocation) async => Right(testTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(OnPopularTv()),
    expect: () => <TvState>[
      TvLoading(),
      TvListHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<PopularTvBloc, TvState>(
    'emits [Loading, Error] when get popular tv is unsuccessful.',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(OnPopularTv()),
    expect: () => <TvState>[
      TvLoading(),
      TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );
}
