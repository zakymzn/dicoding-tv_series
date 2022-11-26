import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_episode_detail.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetTvEpisodeDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(
    () {
      mockTvRepository = MockTvRepository();
      usecase = GetTvEpisodeDetail(mockTvRepository);
    },
  );

  final tId = 1;
  final tSeasonNumber = 1;
  final tEpisodeNumber = 1;

  test(
    'should get tv episode detail from the repository',
    () async {
      when(mockTvRepository.getTvEpisodeDetail(
              tId, tSeasonNumber, tEpisodeNumber))
          .thenAnswer((realInvocation) async => Right(testTvEpisodeDetail));

      final result = await usecase.execute(tId, tSeasonNumber, tEpisodeNumber);

      expect(result, Right(testTvEpisodeDetail));
    },
  );
}
