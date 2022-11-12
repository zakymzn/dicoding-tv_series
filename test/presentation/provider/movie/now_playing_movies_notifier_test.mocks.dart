import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/movie/movie.dart' as _i7;
import 'package:ditonton/domain/repositories/movie_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

class _FakeMovieRepository extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class MockGetNowPlayingMovies extends _i1.Mock
    implements _i4.GetNowPlayingMovies {
  MockGetNowPlayingMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as _i2.MovieRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Movie>>>.value(
              _FakeEither<_i6.Failure, List<_i7.Movie>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Movie>>>);
}
