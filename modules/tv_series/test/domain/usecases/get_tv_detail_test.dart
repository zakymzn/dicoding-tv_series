import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  const tId = 1;

  test(
    'should get tv detail from the repository',
    () async {
      when(mockTvRepository.getTvDetail(tId))
          .thenAnswer((_) async => const Right(testTvDetail));

      final result = await usecase.execute(tId);

      expect(result, const Right(testTvDetail));
    },
  );
}
