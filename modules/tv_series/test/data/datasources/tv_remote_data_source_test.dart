import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../json_reader.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Tv', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('/dummy_data/now_playing_tv.json')))
        .tvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('/dummy_data/now_playing_tv.json'), 200));

      final result = await dataSource.getNowPlayingTv();
      expect(result, equals(tTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getNowPlayingTv();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('/dummy_data/popular_tv.json')))
        .tvList;

    test('should return list of tv when response is success (200)', () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('/dummy_data/popular_tv.json'), 200));

      final result = await dataSource.getPopularTv();

      expect(result, tTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getPopularTv();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('/dummy_data/top_rated_tv.json')))
        .tvList;

    test('should return list of tv when response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('/dummy_data/top_rated_tv.json'), 200));

      final result = await dataSource.getTopRatedTv();

      expect(result, tTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTopRatedTv();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
        json.decode(readJson('/dummy_data/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('/dummy_data/tv_detail.json'), 200));

      final result = await dataSource.getTvDetail(tId);

      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTvDetail(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group(
    'get tv season detail',
    () {
      const tId = 1;
      const tSeasonNumber = 1;
      final tTvSeasonDetail = TvSeasonDetailResponse.fromJson(
          json.decode(readJson('/dummy_data/tv_season_detail.json')));

      test(
        'should return tv season detail when the response is 200',
        () async {
          when(mockHttpClient.get(
                  Uri.parse('$baseUrl/tv/$tId/season/$tSeasonNumber?$apiKey')))
              .thenAnswer((realInvocation) async => http.Response(
                  readJson('/dummy_data/tv_season_detail.json'), 200));

          final result = await dataSource.getTvSeasonDetail(tId, tSeasonNumber);

          expect(result, equals(tTvSeasonDetail));
        },
      );

      test(
        'should throw Server Exception when the response code is 404 or other',
        () async {
          when(mockHttpClient.get(
                  Uri.parse('$baseUrl/tv/$tId/season/$tSeasonNumber?$apiKey')))
              .thenAnswer(
                  (realInvocation) async => http.Response('Not Found', 404));

          final call = dataSource.getTvSeasonDetail(tId, tSeasonNumber);

          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'get tv episode detail',
    () {
      const tId = 1;
      const tSeasonNumber = 1;
      const tEpisodeNumber = 1;
      final tTvEpisodeDetail = TvEpisodeDetailResponse.fromJson(
          json.decode(readJson('/dummy_data/tv_episode_detail.json')));

      test(
        'should return tv episode detail when then response is 200',
        () async {
          when(mockHttpClient.get(Uri.parse(
                  '$baseUrl/tv/$tId/season/$tSeasonNumber/episode/$tEpisodeNumber?$apiKey')))
              .thenAnswer((realInvocation) async => http.Response(
                  readJson('/dummy_data/tv_episode_detail.json'), 200));

          final result = await dataSource.getTvEpisodeDetail(
              tId, tSeasonNumber, tEpisodeNumber);

          expect(result, equals(tTvEpisodeDetail));
        },
      );

      test(
        'should throw Server Exception when the response code is 404 or other',
        () async {
          when(mockHttpClient.get(Uri.parse(
                  '$baseUrl/tv/$tId/season/$tSeasonNumber/episode/$tEpisodeNumber?$apiKey')))
              .thenAnswer(
                  (realInvocation) async => http.Response('Not Found', 404));

          final call =
              dataSource.getTvEpisodeDetail(tId, tSeasonNumber, tEpisodeNumber);

          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group('get tv recommendations', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('/dummy_data/tv_recommendations.json')))
        .tvList;
    final tId = 1;

    test('should return list of tv Model when the response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('/dummy_data/tv_recommendations.json'), 200));

      final result = await dataSource.getTvRecommendations(tId);

      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.getTvRecommendations(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('/dummy_data/search_game_of_thrones_tv.json')))
        .tvList;
    final tQuery = 'game';

    test('should return list of tv when response code is 200', () async {
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('/dummy_data/search_game_of_thrones_tv.json'), 200));

      final result = await dataSource.searchTv(tQuery);

      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = dataSource.searchTv(tQuery);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
