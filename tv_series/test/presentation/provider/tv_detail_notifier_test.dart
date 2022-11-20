import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
import 'package:core/utils/failure.dart';
import 'package:tv_series/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv_series/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_watchlist.dart';
import 'package:tv_series/presentation/provider/tv_detail_notifier.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetTvWatchListStatus mockGetTvWatchListStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetTvDetail = MockGetTvDetail();
      mockGetTvRecommendations = MockGetTvRecommendations();
      mockGetTvWatchListStatus = MockGetTvWatchListStatus();
      mockSaveTvWatchlist = MockSaveTvWatchlist();
      mockRemoveTvWatchlist = MockRemoveTvWatchlist();
      provider = TvDetailNotifier(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecommendations,
        getTvWatchListStatus: mockGetTvWatchListStatus,
        saveTvWatchlist: mockSaveTvWatchlist,
        removeTvWatchlist: mockRemoveTvWatchlist,
      )..addListener(() {
          listenerCallCount += 1;
        });
    },
  );

  final tId = 1;

  final tTv = Tv(
    posterPath: 'posterPath',
    popularity: 1,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['originCountry'],
    genreIds: [1],
    originalLanguage: 'originalLanguage',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
  );

  final tTvs = <Tv>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvs));
  }

  group(
    'Get Tv Detail',
    () {
      test('should get data from the usecase', () async {
        // arrange
        _arrangeUsecase();
        // act
        await provider.fetchTvDetail(tId);
        // assert
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      });

      test('should change state to loading when usecase is called', () {
        // arrange
        _arrangeUsecase();
        // act
        provider.fetchTvDetail(tId);
        // assert
        expect(provider.tvState, RequestState.loading);
        expect(listenerCallCount, 1);
      });

      test('should change tv when data is gotten successfully', () async {
        // arrange
        _arrangeUsecase();
        // act
        await provider.fetchTvDetail(tId);
        // assert
        expect(provider.tvState, RequestState.loaded);
        expect(provider.tv, testTvDetail);
        expect(listenerCallCount, 3);
      });

      test('should change recommendation tvs when data is gotten successfully',
          () async {
        // arrange
        _arrangeUsecase();
        // act
        await provider.fetchTvDetail(tId);
        // assert
        expect(provider.tvState, RequestState.loaded);
        expect(provider.tvRecommendations, tTvs);
      });
    },
  );

  group(
    'Get Tv Recommendations',
    () {
      test('should get data from the usecase', () async {
        // arrange
        _arrangeUsecase();
        // act
        await provider.fetchTvDetail(tId);
        // assert
        verify(mockGetTvRecommendations.execute(tId));
        expect(provider.tvRecommendations, tTvs);
      });

      test(
          'should update recommendation state when data is gotten successfully',
          () async {
        // arrange
        _arrangeUsecase();
        // act
        await provider.fetchTvDetail(tId);
        // assert
        expect(provider.recommendationState, RequestState.loaded);
        expect(provider.tvRecommendations, tTvs);
      });

      test('should update error message when request in successful', () async {
        // arrange
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        // act
        await provider.fetchTvDetail(tId);
        // assert
        expect(provider.recommendationState, RequestState.error);
        expect(provider.message, 'Failed');
      });
    },
  );

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetTvWatchListStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadTvWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockSaveTvWatchlist.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveTvWatchlist.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockGetTvWatchListStatus.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when remove watchlist is failed',
        () async {
      // arrange
      when(mockRemoveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvs));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
