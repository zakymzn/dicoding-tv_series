import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv, GetPopularTv, GetTopRatedTv])
void main() {
  late TvListNotifier provider;
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetNowPlayingTv = MockGetNowPlayingTv();
      mockGetPopularTv = MockGetPopularTv();
      mockGetTopRatedTv = MockGetTopRatedTv();
      provider = TvListNotifier(
        getNowPlayingTv: mockGetNowPlayingTv,
        getPopularTv: mockGetPopularTv,
        getTopRatedTv: mockGetTopRatedTv,
      )..addListener(() {
          listenerCallCount += 1;
        });
    },
  );

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
  final tTvList = <Tv>[tTv];

  group(
    'now playing tv',
    () {
      test('initialState should be empty', () {
        expect(provider.nowPlayingState, equals(RequestState.empty));
      });

      test('should get data from the usecase', () async {
        // arrange
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        // act
        provider.fetchNowPlayingTv();
        // assert
        verify(mockGetNowPlayingTv.execute());
      });

      test('should change state to loading when usecase is called', () {
        // arrange
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        // act
        provider.fetchNowPlayingTv();
        // assert
        expect(provider.nowPlayingState, RequestState.loading);
      });

      test('should change tv when data is gotten successfully', () async {
        // arrange
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        // act
        await provider.fetchNowPlayingTv();
        // assert
        expect(provider.nowPlayingState, RequestState.loaded);
        expect(provider.nowPlayingTv, tTvList);
        expect(listenerCallCount, 2);
      });

      test('should return error when data is unsuccessful', () async {
        // arrange
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        // act
        await provider.fetchNowPlayingTv();
        // assert
        expect(provider.nowPlayingState, RequestState.error);
        expect(provider.message, 'Server Failure');
        expect(listenerCallCount, 2);
      });
    },
  );

  group(
    'popular tv',
    () {
      test('should change state to loading when usecase is called', () async {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));

        provider.fetchPopularTv();

        expect(provider.popularTvState, RequestState.loading);
      });

      test(
        'should change tv data when data is gotten successfully',
        () async {
          when(mockGetPopularTv.execute())
              .thenAnswer((_) async => Right(tTvList));

          await provider.fetchPopularTv();

          expect(provider.popularTvState, RequestState.loaded);
          expect(provider.popularTv, tTvList);
          expect(listenerCallCount, 2);
        },
      );

      test('should return error when data is unsuccessful', () async {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        await provider.fetchPopularTv();

        expect(provider.popularTvState, RequestState.error);
        expect(provider.message, 'Server Failure');
        expect(listenerCallCount, 2);
      });
    },
  );

  group('top rated tv', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));

      provider.fetchTopRatedTv();

      expect(provider.topRatedTvState, RequestState.loading);
    });

    test('should change tv data when data is gotten successfully', () async {
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));

      await provider.fetchTopRatedTv();

      expect(provider.topRatedTvState, RequestState.loaded);
      expect(provider.topRatedTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTopRatedTv();

      expect(provider.topRatedTvState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
