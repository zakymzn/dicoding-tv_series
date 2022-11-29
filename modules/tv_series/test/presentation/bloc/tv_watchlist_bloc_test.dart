import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_watchlist_bloc_test.mocks.dart';
import '../../dummy_data/tv_dummy_objects.dart';

@GenerateMocks([
  GetWatchlistTv,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;

  setUp(
    () {
      mockGetWatchlistTv = MockGetWatchlistTv();
      mockGetTvWatchListStatus = MockGetTvWatchListStatus();
      mockSaveTvWatchlist = MockSaveTvWatchlist();
      mockRemoveTvWatchlist = MockRemoveTvWatchlist();
      tvWatchlistBloc = TvWatchlistBloc(
        mockGetTvWatchListStatus,
        mockGetWatchlistTv,
        mockRemoveTvWatchlist,
        mockSaveTvWatchlist,
      );
    },
  );

  test(
    'initial state should be empty',
    () {
      expect(tvWatchlistBloc.state, TvEmpty());
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((realInvocation) async => Right(testTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnTvWatchlist()),
    expect: () => <TvState>[
      TvLoading(),
      TvListHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'emits [Loading, Error] when get watchlist tv is unsuccessful.',
    build: () {
      when(mockGetWatchlistTv.execute()).thenAnswer((realInvocation) async =>
          const Left(DatabaseFailure("Can't get data")));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnTvWatchlist()),
    expect: () => <TvState>[
      TvLoading(),
      const TvError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'emits [Loading, TvWatchlistStatus] when status is gotten successfully.',
    build: () {
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnTvWatchlistStatus(testTvDetail.id)),
    expect: () => <TvState>[
      TvLoading(),
      const TvWatchlistStatus(true),
    ],
    verify: (bloc) {
      verify(mockGetTvWatchListStatus.execute(testTvDetail.id));
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'emits [Loading, TvWatchlistMessage] when add tv to watchlist is successfully.',
    build: () {
      when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer(
          (realInvocation) async =>
              const Right(TvWatchlistBloc.watchlistAddSuccessMessage));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const OnAddTvWatchlist(testTvDetail)),
    expect: () => <TvState>[
      TvLoading(),
      const TvWatchlistMessage(TvWatchlistBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveTvWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'emits [Loading, Error] when add tv to watchlist is unsuccessful.',
    build: () {
      when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer(
          (realInvocation) async => const Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => false);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const OnAddTvWatchlist(testTvDetail)),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveTvWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'emits [Loading, TvWatchlistMessage] when remove tv from watchlist is successfully.',
    build: () {
      when(mockRemoveTvWatchlist.execute(testTvDetail)).thenAnswer(
          (realInvocation) async =>
              const Right(TvWatchlistBloc.watchlistRemoveSuccessMessage));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => false);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const OnRemoveTvWatchlist(testTvDetail)),
    expect: () => <TvState>[
      TvLoading(),
      const TvWatchlistMessage(TvWatchlistBloc.watchlistRemoveSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveTvWatchlist.execute(testTvDetail));
    },
  );

  blocTest<TvWatchlistBloc, TvState>(
    'emits [Loading, Error] when remove tv from watchlist is unsuccessful.',
    build: () {
      when(mockRemoveTvWatchlist.execute(testTvDetail)).thenAnswer(
          (realInvocation) async => const Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((realInvocation) async => true);
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(const OnRemoveTvWatchlist(testTvDetail)),
    expect: () => <TvState>[
      TvLoading(),
      const TvError('Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveTvWatchlist.execute(testTvDetail));
    },
  );
}
