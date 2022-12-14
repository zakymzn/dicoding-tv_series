import 'dart:convert';

import 'package:tv_series/data/models/tv_model.dart';
import 'package:tv_series/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tTvModel = TvModel(
    posterPath: 'posterPath',
    popularity: 1,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1,
    overview: 'overview',
    firstAirDate: '2022-10-29',
    originCountry: ['originCountry'],
    genreIds: [1],
    originalLanguage: 'originalLanguage',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
  );

  const tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));

      final result = TvResponse.fromJson(jsonMap);

      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvResponseModel.toJson();

      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "posterPath",
            "popularity": 1,
            "id": 1,
            "backdrop_path": "backdropPath",
            "vote_average": 1,
            "overview": "overview",
            "first_air_date": "2022-10-29",
            "origin_country": ["originCountry"],
            "genre_ids": [1],
            "original_language": "originalLanguage",
            "vote_count": 1,
            "name": "name",
            "original_name": "originalName"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
