import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';

void main() {
  test(
    'test search movies event',
    () async {
      expect(const OnMoviesQueryChanged('query'),
          const OnMoviesQueryChanged('query'));
    },
  );
}
