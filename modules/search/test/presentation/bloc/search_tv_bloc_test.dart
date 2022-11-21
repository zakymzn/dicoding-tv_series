import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTv mockSearchTv;

  final tTvModel = Tv(
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

  final tTvList = <Tv>[tTvModel];
  final tQuery = 'game of thrones';

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  setUp(
    () {
      mockSearchTv = MockSearchTv();
      searchTvBloc = SearchTvBloc(mockSearchTv);
    },
  );

  test('initial state should be empty', () {
    expect(searchTvBloc.state, SearchTvEmpty());
  });
}
