import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/presentation/provider/popular_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvNotifier notifier;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetPopularTv = MockGetPopularTv();
      notifier = PopularTvNotifier(mockGetPopularTv)
        ..addListener(() {
          listenerCallCount++;
        });
    },
  );

  final tTv = Tv(
    posterPath: 'posterPath',
    popularity: 1,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['originCountry'],
    genreIds: [1],
    originalLanguage: 'originalLanguage',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
  );

  final tTvList = <Tv>[tTv];

  test(
    'should change state to loading when usecase is called',
    () async {
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      notifier.fetchPopularTv();
      expect(notifier.state, RequestState.loading);
      expect(listenerCallCount, 1);
    },
  );

  test('should change tv data when data is gotten successfully', () async {
    when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));

    await notifier.fetchPopularTv();

    expect(notifier.state, RequestState.loaded);
    expect(notifier.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetPopularTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    await notifier.fetchPopularTv();

    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
