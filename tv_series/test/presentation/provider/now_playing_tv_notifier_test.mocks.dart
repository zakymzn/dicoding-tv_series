import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:core/utils/failure.dart' as _i6;
import 'package:tv_series/domain/entities/tv.dart' as _i7;
import 'package:tv_series/domain/repositories/tv_repository.dart' as _i2;
import 'package:tv_series/domain/usecases/get_now_playing_tv.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

class _FakeTvRepository extends _i1.Fake implements _i2.TvRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class MockGetNowPlayingTv extends _i1.Mock implements _i4.GetNowPlayingTv {
  MockGetNowPlayingTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository()) as _i2.TvRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>.value(
                  _FakeEither<_i6.Failure, List<_i7.Tv>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Tv>>>);
}
