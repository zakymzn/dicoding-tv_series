import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'now_playing_movies_bloc_test.mocks.dart';
import '../../dummy_data/movie_dummy_objects.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(
    () {
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
    },
  );

  test('initial state should be empty', () {
    expect(nowPlayingMoviesBloc.state, MovieEmpty());
  });

  blocTest<NowPlayingMoviesBloc, MovieState>(
    'emits [Loading, HasData] when data is gotten successfully.',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(testMovieList));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingMovies()),
    expect: () => <MovieState>[
      MovieLoading(),
      MovieListHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMoviesBloc, MovieState>(
    'emits [Loading, Error] when get now playing movies is unsuccessful.',
    build: () {
      when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return nowPlayingMoviesBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingMovies()),
    expect: () => <MovieState>[
      MovieLoading(),
      const MovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
