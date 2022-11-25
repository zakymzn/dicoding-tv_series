import 'dart:convert';

import 'package:core/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';
import '../../../lib/data/models/genre_response.dart';

void main() {
  final tGenreModel = GenreModel(
    id: 1,
    name: "name",
  );

  final tGenreResponseModel =
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
