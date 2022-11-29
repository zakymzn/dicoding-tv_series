import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_recommendations_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationsBloc tvRecommendationsBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(
    () {
      mockGetTvRecommendations = MockGetTvRecommendations();
      tvRecommendationsBloc = TvRecommendationsBloc(mockGetTvRecommendations);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(tvRecommendationsBloc.state, TvEmpty());
    },
  );

  blocTest<TvRecommendationsBloc, TvState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetTvRecommendations.execute(testTv.id))
          .thenAnswer((realInvocation) async => Right(testTvList));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnTvRecommendations(testTv.id)),
    expect: () => <TvState>[
      TvLoading(),
      TvListHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(testTv.id));
    },
  );

  blocTest<TvRecommendationsBloc, TvState>(
    'emits [Loading, Error] when get tv recommendations is unsuccessful.',
    build: () {
      when(mockGetTvRecommendations.execute(testTv.id)).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return tvRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnTvRecommendations(testTv.id)),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(testTv.id));
    },
  );
}
