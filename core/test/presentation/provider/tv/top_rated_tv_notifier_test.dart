import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:core/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvNotifier notifier;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetTopRatedTv = MockGetTopRatedTv();
      notifier = TopRatedTvNotifier(getTopRatedTv: mockGetTopRatedTv)
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

  test('should change state to loading when usecase is called', () async {
    when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));

    notifier.fetchTopRatedTv();

    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));

    await notifier.fetchTopRatedTv();

    expect(notifier.state, RequestState.loaded);
    expect(notifier.tv, tTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetTopRatedTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    await notifier.fetchTopRatedTv();

    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
