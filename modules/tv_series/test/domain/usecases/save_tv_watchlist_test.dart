import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveTvWatchlist(mockTvRepository);
  });

  test('should save tv to the repository', () async {
    when(mockTvRepository.saveWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));

    final result = await usecase.execute(testTvDetail);

    verify(mockTvRepository.saveWatchlist(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
