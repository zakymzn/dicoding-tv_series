// Mocks generated by Mockito 5.3.2 from annotations
// in tv_series/test/presentation/provider/tv_detail_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:core/core.dart' as _i5;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv_series/tv_series.dart' as _i2;

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

class _FakeTvRepository_0 extends _i1.SmartFake implements _i2.TvRepository {
  _FakeTvRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTvDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvDetail extends _i1.Mock implements _i2.GetTvDetail {
  MockGetTvDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
  @override
  _i4.Future<_i3.Either<_i5.Failure, _i2.TvDetail>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i4.Future<_i3.Either<_i5.Failure, _i2.TvDetail>>.value(
            _FakeEither_1<_i5.Failure, _i2.TvDetail>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i5.Failure, _i2.TvDetail>>);
}

/// A class which mocks [GetTvRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvRecommendations extends _i1.Mock
    implements _i2.GetTvRecommendations {
  MockGetTvRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
  @override
  _i4.Future<_i3.Either<_i5.Failure, List<_i2.Tv>>> execute(dynamic id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i4.Future<_i3.Either<_i5.Failure, List<_i2.Tv>>>.value(
            _FakeEither_1<_i5.Failure, List<_i2.Tv>>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i5.Failure, List<_i2.Tv>>>);
}

/// A class which mocks [GetTvWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvWatchListStatus extends _i1.Mock
    implements _i2.GetTvWatchListStatus {
  MockGetTvWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
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
class MockSaveTvWatchlist extends _i1.Mock implements _i2.SaveTvWatchlist {
  MockSaveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
  @override
  _i4.Future<_i3.Either<_i5.Failure, String>> execute(_i2.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tv],
        ),
        returnValue: _i4.Future<_i3.Either<_i5.Failure, String>>.value(
            _FakeEither_1<_i5.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tv],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i5.Failure, String>>);
}

/// A class which mocks [RemoveTvWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveTvWatchlist extends _i1.Mock implements _i2.RemoveTvWatchlist {
  MockRemoveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTvRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TvRepository);
  @override
  _i4.Future<_i3.Either<_i5.Failure, String>> execute(_i2.TvDetail? tv) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [tv],
        ),
        returnValue: _i4.Future<_i3.Either<_i5.Failure, String>>.value(
            _FakeEither_1<_i5.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [tv],
          ),
        )),
      ) as _i4.Future<_i3.Either<_i5.Failure, String>>);
}
