import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/save_tv_watchlist.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv/tv_dummy_objects.dart';
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
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetTvDetail = MockGetTvDetail();
      mockGetTvRecommendations = MockGetTvRecommendations();
      mockGetWatchListStatus = MockGetWatchListStatus();
      mockSaveWatchlist = MockSaveWatchlist();
      mockRemoveWatchlist = MockRemoveWatchlist();
      provider = TvDetailNotifier(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecommendations,
        getTvWatchListStatus: mockGetWatchListStatus,
        saveTvWatchlist: mockSaveWatchlist,
        removeTvWatchlist: mockRemoveWatchlist,
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

      test('should change state to Loading when usecase is called', () {
        // arrange
        _arrangeUsecase();
        // act
        provider.fetchTvDetail(tId);
        // assert
        expect(provider.tvState, RequestState.Loading);
        expect(listenerCallCount, 1);
      });

      test('should change tv when data is gotten successfully', () async {
        // arrange
        _arrangeUsecase();
        // act
        await provider.fetchTvDetail(tId);
        // assert
        expect(provider.tvState, RequestState.Loaded);
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
        expect(provider.tvState, RequestState.Loaded);
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
        expect(provider.recommendationState, RequestState.Loaded);
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
        expect(provider.recommendationState, RequestState.Error);
        expect(provider.message, 'Failed');
      });
    },
  );
}
