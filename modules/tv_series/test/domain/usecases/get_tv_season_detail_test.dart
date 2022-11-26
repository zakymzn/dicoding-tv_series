import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetTvSeasonDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(
    () {
      mockTvRepository = MockTvRepository();
      usecase = GetTvSeasonDetail(mockTvRepository);
    },
  );

  final tId = 1;
  final tSeasonNumber = 1;

  test(
    'should get tv season detail from the repository',
    () async {
      when(mockTvRepository.getTvSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((realInvocation) async => Right(testTvSeasonDetail));

      final result = await usecase.execute(tId, tSeasonNumber);

      expect(result, Right(testTvSeasonDetail));
    },
  );
}
