import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

import '../helpers/search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTv mockSearchTv;

  setUp(
    () {
      mockSearchTv = MockSearchTv();
      searchTvBloc = SearchTvBloc(mockSearchTv);
    },
  );

  final tTvModel = Tv(
    posterPath: 'posterPath',
    popularity: 1,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: const ['originCountry'],
    genreIds: const [1],
    originalLanguage: 'originalLanguage',
    voteCount: 1,
    name: 'name',
    originalName: 'originalName',
  );

  final tTvList = <Tv>[tTvModel];
  const tQuery = 'game of thrones';

  blocTest<SearchTvBloc, SearchTvState>(
    'debounce test',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const OnTvQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvLoading(),
      SearchTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  final tMultiArgument = MultiArgument(1, 2);

  final tTripleArgument = TripleArgument(1, 2, 3);

  test(
    'test multi argument',
    () async {
      expect(tMultiArgument, isA<MultiArgument>());
      expect(tMultiArgument.arg1, isA<int>());
      expect(tMultiArgument.arg2, isA<int>());
      expect(tMultiArgument.arg1, 1);
      expect(tMultiArgument.arg2, 2);
    },
  );

  test('test triple argument', () async {
    expect(tTripleArgument, isA<TripleArgument>());
    expect(tTripleArgument.arg1, isA<int>());
    expect(tTripleArgument.arg2, isA<int>());
    expect(tTripleArgument.arg3, isA<int>());
    expect(tTripleArgument.arg1, 1);
    expect(tTripleArgument.arg2, 2);
    expect(tTripleArgument.arg3, 3);
  });
}
