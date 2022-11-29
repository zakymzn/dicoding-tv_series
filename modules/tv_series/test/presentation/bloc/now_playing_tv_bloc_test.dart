import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'now_playing_tv_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTv mockGetNowPlayingTv;

  setUp(
    () {
      mockGetNowPlayingTv = MockGetNowPlayingTv();
      nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(nowPlayingTvBloc.state, TvEmpty());
    },
  );

  blocTest<NowPlayingTvBloc, TvState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((realInvocation) async => Right(testTvList));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTv()),
    expect: () => <TvState>[
      TvLoading(),
      TvListHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );

  blocTest<NowPlayingTvBloc, TvState>(
    'emits [Loading, Error] when get now playing tv is unsuccessful.',
    build: () {
      when(mockGetNowPlayingTv.execute()).thenAnswer((realInvocation) async =>
          const Left(ServerFailure('Server Failure')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTv()),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
    },
  );
}
