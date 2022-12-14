// Mocks generated by Mockito 5.3.2 from annotations
// in tv_series/test/presentation/bloc/tv_watchlist_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:core/core.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_series/tv_series.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTvRepository_1 extends _i1.SmartFake implements _i3.TvRepository {
  _FakeTvRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTv extends _i1.Mock implements _i3.GetWatchlistTv {
  MockGetWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i3.Tv>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i3.Tv>>>.value(
            _FakeEither_0<_i5.Failure, List<_i3.Tv>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i3.Tv>>>);
}

/// A class which mocks [GetTvWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvWatchListStatus extends _i1.Mock
    implements _i3.GetTvWatchListStatus {
  MockGetTvWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TvRepository);
  @override
  _i4.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [SaveTvWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTvWatchlist extends _i1.Mock implements _i3.SaveTvWatchlist {
  MockSaveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TvRepository);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> execute(_i3.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tv],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tv],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
}

/// A class which mocks [RemoveTvWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveTvWatchlist extends _i1.Mock implements _i3.RemoveTvWatchlist {
  MockRemoveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_1(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i3.TvRepository);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> execute(_i3.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tv],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tv],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
}
