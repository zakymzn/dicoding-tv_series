import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/presentation/provider/movie/now_playing_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_movies_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMoviesNotifier notifier;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      notifier = NowPlayingMoviesNotifier(mockGetNowPlayingMovies)
        ..addListener(() {
          listenerCallCount++;
        });
    },
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchNowPlayingMovies();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchNowPlayingMovies();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingMovies.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingMovies();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
