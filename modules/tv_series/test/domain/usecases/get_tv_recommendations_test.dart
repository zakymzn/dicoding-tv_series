import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  const tId = 1;
  final tTv = <Tv>[];

  test('should get list of tv recommendations from the repository', () async {
    when(mockTvRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tTv));

    final result = await usecase.execute(tId);

    expect(result, Right(tTv));
  });
}
