import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTvModel = TvModel(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: ["US"],
    genreIds: [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars",
  );

  final tTv = Tv(
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    popularity: 47.432451,
    id: 31917,
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    voteAverage: 5.04,
    overview:
        "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
    firstAirDate: "2010-06-08",
    originCountry: const ["US"],
    genreIds: const [18, 9648],
    originalLanguage: "en",
    voteCount: 133,
    name: "Pretty Little Liars",
    originalName: "Pretty Little Liars",
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Now Playing Tv', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        when(mockRemoteDataSource.getNowPlayingTv())
            .thenAnswer((_) async => tTvModelList);

        final result = await repository.getNowPlayingTv();

        verify(mockRemoteDataSource.getNowPlayingTv());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      },
    );

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getNowPlayingTv()).thenThrow(ServerException());

      final result = await repository.getNowPlayingTv();

      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteDataSource.getNowPlayingTv())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getNowPlayingTv();

      verify(mockRemoteDataSource.getNowPlayingTv());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv', () {
    test('should return tv list when call to data source is success', () async {
      when(mockRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getPopularTv();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());

      final result = await repository.getPopularTv();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getPopularTv())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getPopularTv();

      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv', () {
    test('should return tv list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getTopRatedTv();

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());

      final result = await repository.getTopRatedTv();

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteDataSource.getTopRatedTv())
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTopRatedTv();

      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group(
    'Get Tv Detail',
    () {
      const tId = 1;
      const tTvResponse = TvDetailResponse(
        backdropPath: 'backdropPath',
        createdBy: [
          CreatedByModel(
              id: 1,
              creditId: 'creditId',
              name: 'name',
              gender: 1,
              profilePath: 'profilePath')
        ],
        episodeRunTime: [1],
        firstAirDate: 'firstAirDate',
        genres: [GenreModel(id: 1, name: 'name')],
        homepage: 'homepage',
        id: 1,
        inProduction: true,
        languages: ['languages'],
        lastAirDate: 'lastAirDate',
        lastEpisodeToAir: LastEpisodeToAirModel(
          airDate: 'airDate',
          episodeNumber: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          productionCode: 'productionCode',
          runtime: 1,
          seasonNumber: 1,
          stillPath: 'stillPath',
          voteAverage: 1,
          voteCount: 1,
        ),
        name: 'name',
        nextEpisodeToAir: 1,
        networks: ['networks'],
        numberOfEpisodes: 1,
        numberOfSeasons: 1,
        originCountry: ['originCountry'],
        originalLanguage: 'originalLanguage',
        originalName: 'originalName',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        productionCompanies: ['productionCompanies'],
        productionCountries: ['productionCountries'],
        seasons: [
          SeasonModel(
            airDate: 'airDate',
            episodeCount: 1,
            id: 1,
            name: 'name',
            overview: 'overview',
            posterPath: 'posterPath',
            seasonNumber: 1,
          )
        ],
        status: 'status',
        tagline: 'tagline',
        type: 'type',
        voteAverage: 1,
        voteCount: 1,
      );

      test(
          'should return Tv data when the call to remote data source is successful',
          () async {
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenAnswer((_) async => tTvResponse);

        final result = await repository.getTvDetail(tId);

        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(result, equals(const Right(testTvDetail)));
      });

      test(
          'should return Server Failure when the call to remote data source is unsuccessful',
          () async {
        when(mockRemoteDataSource.getTvDetail(tId))
            .thenThrow(ServerException());

        final result = await repository.getTvDetail(tId);

        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(result, equals(const Left(ServerFailure(''))));
      });

      test(
          'should return connection failure when the device is not connected to internet',
          () async {
        when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        final result = await repository.getTvDetail(tId);

        verify(mockRemoteDataSource.getTvDetail(tId));
        expect(
            result,
            equals(const Left(
                ConnectionFailure('Failed to connect to the network'))));
      });
    },
  );

  group(
    'Get tv season detail',
    () {
      const tId = 1;
      const tSeasonNumber = 1;
      final tTvSeasonDetailResponse = TvSeasonDetailResponse(
        id: 'id',
        airDate: 'airDate',
        episodes: [
          EpisodeModel(
            airDate: 'airDate',
            episodeNumber: 1,
            crew: [
              CrewInSeasonDetailModel(
                department: 'department',
                job: 'job',
                creditId: 'creditId',
                adult: false,
                gender: 1,
                id: 1,
                knownForDepartment: 'knownForDepartment',
                name: 'name',
                originalName: 'originalName',
                popularity: 1,
                profilePath: 'profilePath',
                order: 1,
                character: 'character',
              )
            ],
            guestStars: [
              CrewInSeasonDetailModel(
                department: 'department',
                job: 'job',
                creditId: 'creditId',
                adult: false,
                gender: 1,
                id: 1,
                knownForDepartment: 'knownForDepartment',
                name: 'name',
                originalName: 'originalName',
                popularity: 1,
                profilePath: 'profilePath',
                order: 1,
                character: 'character',
              )
            ],
            id: 1,
            name: 'name',
            overview: 'overview',
            productionCode: 'productionCode',
            seasonNumber: 1,
            stillPath: 'stillPath',
            voteAverage: 1,
            voteCount: 1,
          ),
        ],
        name: 'name',
        overview: 'overview',
        seasonDetailId: 1,
        posterPath: 'posterPath',
        seasonNumber: 1,
      );

      test(
        'should return tv season detail data when the call to remote source is successful',
        () async {
          when(mockRemoteDataSource.getTvSeasonDetail(tId, tSeasonNumber))
              .thenAnswer((realInvocation) async => tTvSeasonDetailResponse);

          final result = await repository.getTvSeasonDetail(tId, tSeasonNumber);

          verify(mockRemoteDataSource.getTvSeasonDetail(tId, tSeasonNumber));
          expect(result, equals(Right(testTvSeasonDetail)));
        },
      );

      test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
          when(mockRemoteDataSource.getTvSeasonDetail(tId, tSeasonNumber))
              .thenThrow(ServerException());

          final result = await repository.getTvSeasonDetail(tId, tSeasonNumber);

          verify(mockRemoteDataSource.getTvSeasonDetail(tId, tSeasonNumber));
          expect(result, equals(const Left(ServerFailure(''))));
        },
      );

      test(
        'should return connection failure when the device is not connected to internet',
        () async {
          when(mockRemoteDataSource.getTvSeasonDetail(tId, tSeasonNumber))
              .thenThrow(
                  const SocketException('Failed to connect to the network'));

          final result = await repository.getTvSeasonDetail(tId, tSeasonNumber);

          verify(mockRemoteDataSource.getTvSeasonDetail(tId, tSeasonNumber));
          expect(
              result,
              equals(const Left(
                  ConnectionFailure('Failed to connect to the network'))));
        },
      );
    },
  );

  group(
    'Get tv episode detail',
    () {
      const tId = 1;
      const tSeasonNumber = 1;
      const tEpisodeNumber = 1;
      final tTvEpisodeDetailResponse = TvEpisodeDetailResponse(
        airDate: 'airDate',
        crew: [
          CrewInEpisodeDetailModel(
            id: 1,
            creditId: 'creditId',
            name: 'name',
            department: 'department',
            job: 'job',
            profilePath: 'profilePath',
          ),
        ],
        episodeNumber: 1,
        guestStars: [
          GuestStarModel(
            id: 1,
            name: 'name',
            creditId: 'creditId',
            character: 'character',
            order: 1,
            profilePath: 'profilePath',
          ),
        ],
        name: 'name',
        overview: 'overview',
        id: 1,
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 1,
        voteCount: 1,
      );

      test(
        'should return tv episode detail data when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getTvEpisodeDetail(
                  tId, tSeasonNumber, tEpisodeNumber))
              .thenAnswer((realInvocation) async => tTvEpisodeDetailResponse);

          final result = await repository.getTvEpisodeDetail(
              tId, tSeasonNumber, tEpisodeNumber);

          verify(mockRemoteDataSource.getTvEpisodeDetail(
              tId, tSeasonNumber, tEpisodeNumber));
          expect(result, equals(Right(testTvEpisodeDetail)));
        },
      );

      test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
          when(mockRemoteDataSource.getTvEpisodeDetail(
                  tId, tSeasonNumber, tEpisodeNumber))
              .thenThrow(ServerException());

          final result = await repository.getTvEpisodeDetail(
              tId, tSeasonNumber, tEpisodeNumber);

          verify(mockRemoteDataSource.getTvEpisodeDetail(
              tId, tSeasonNumber, tEpisodeNumber));
          expect(result, equals(const Left(ServerFailure(''))));
        },
      );

      test(
        'should return connection failure when the device is not connected to internet',
        () async {
          when(mockRemoteDataSource.getTvEpisodeDetail(
                  tId, tSeasonNumber, tEpisodeNumber))
              .thenThrow(
                  const SocketException('Failed to connect to the network'));

          final result = await repository.getTvEpisodeDetail(
              tId, tSeasonNumber, tEpisodeNumber);

          verify(mockRemoteDataSource.getTvEpisodeDetail(
              tId, tSeasonNumber, tEpisodeNumber));
          expect(
              result,
              equals(const Left(
                  ConnectionFailure('Failed to connect to the network'))));
        },
      );
    },
  );

  group('Get Tv Recommendation', () {
    final tTvList = <TvModel>[];
    const tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);

      final result = await repository.getTvRecommendations(tId);

      verify(mockRemoteDataSource.getTvRecommendations(tId));

      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());

      final result = await repository.getTvRecommendations(tId);

      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internett',
        () async {
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.getTvRecommendations(tId);

      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv', () {
    const tQuery = 'game of thrones';

    test('should return tv list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.searchTv(tQuery);

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(ServerException());

      final result = await repository.searchTv(tQuery);

      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the network',
        () async {
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));

      final result = await repository.searchTv(tQuery);

      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockLocalDataSource.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      final result = await repository.saveWatchlist(testTvDetail);

      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalDataSource.insertTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repository.saveWatchlist(testTvDetail);

      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      when(mockLocalDataSource.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');

      final result = await repository.removeWatchlist(testTvDetail);

      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      when(mockLocalDataSource.removeTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      final result = await repository.removeWatchlist(testTvDetail);

      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      const tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);

      final result = await repository.isAddedToWatchlist(tId);

      expect(result, false);
    });
  });

  group('get watchlist tv', () {
    test('should return list of Tv', () async {
      when(mockLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);

      final result = await repository.getWatchlistTv();

      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
