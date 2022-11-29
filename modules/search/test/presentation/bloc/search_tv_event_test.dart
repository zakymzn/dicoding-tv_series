import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';

void main() {
  test(
    'test search tv event',
    () async {
      expect(OnTvQueryChanged('query'), OnTvQueryChanged('query'));
    },
  );
}
