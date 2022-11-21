import 'package:dartz/dartz.dart';
import 'package:tv_series/tv_series.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchTv(mockTvRepository);
  });

  final tTv = <Tv>[];
  final tQuery = 'Spiderman';

  test('should get list of tv from the repository', () async {
    when(mockTvRepository.searchTv(tQuery)).thenAnswer((_) async => Right(tTv));

    final result = await usecase.execute(tQuery);

    expect(result, Right(tTv));
  });
}
