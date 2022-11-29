import 'dart:convert';

import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/data/models/genre_response.dart';

import '../../json_reader.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: "name",
  );

  const tGenreResponseModel =
      GenreResponse(genreList: <GenreModel>[tGenreModel]);

  test(
    'should return a valid model from JSON',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/genre.json'));
      // act
      final result = GenreResponse.fromJson(jsonMap);
      // assert
      expect(result, tGenreResponseModel);
    },
  );
}
