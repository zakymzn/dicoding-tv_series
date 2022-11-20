import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:core/utils/failure.dart' as _i6;
import 'package:tv_series/domain/entities/tv.dart' as _i9;
import 'package:tv_series/domain/entities/tv_detail.dart' as _i7;
import 'package:tv_series/domain/repositories/tv_repository.dart' as _i2;
import 'package:tv_series/domain/usecases/get_tv_detail.dart' as _i4;
import 'package:tv_series/domain/usecases/get_tv_recommendations.dart' as _i8;
import 'package:tv_series/domain/usecases/get_tv_watchlist_status.dart' as _i10;
import 'package:tv_series/domain/usecases/remove_tv_watchlist.dart' as _i12;
import 'package:tv_series/domain/usecases/save_tv_watchlist.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;

class _FakeTvRepository extends _i1.Fake implements _i2.TvRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class MockGetTvDetail extends _i1.Mock implements _i4.GetTvDetail {
  MockGetTvDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TvDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i6.Failure, _i7.TvDetail>>.value(
                  _FakeEither<_i6.Failure, _i7.TvDetail>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.TvDetail>>);
}

class MockGetTvRecommendations extends _i1.Mock
    implements _i8.GetTvRecommendations {
  MockGetTvRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.Tv>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i6.Failure, List<_i9.Tv>>>.value(
                  _FakeEither<_i6.Failure, List<_i9.Tv>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i9.Tv>>>);
}

class MockGetWatchListStatus extends _i1.Mock
    implements _i10.GetTvWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository()) as _i2.TvRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

class MockSaveWatchlist extends _i1.Mock implements _i11.SaveTvWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

class MockRemoveWatchlist extends _i1.Mock implements _i12.RemoveTvWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}
