import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:core/utils/failure.dart' as _i5;
import 'package:tv_series/domain/entities/tv.dart' as _i6;
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class MockGetWatchlistTv extends _i1.Mock implements _i3.GetWatchlistTv {
  MockGetWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Tv>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Tv>>>.value(
                  _FakeEither<_i5.Failure, List<_i6.Tv>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Tv>>>);
}
