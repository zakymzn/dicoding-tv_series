import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import '../../../../lib/utils/state_enum.dart' as _i4;
import 'package:core/domain/entities/movie/movie.dart' as _i5;
import 'package:core/domain/usecases/movie/get_now_playing_movies.dart' as _i2;
import 'package:core/presentation/provider/movie/now_playing_movies_notifier.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

class _FakeGetNowPlayingMovies extends _i1.Fake
    implements _i2.GetNowPlayingMovies {}

class MockNowPlayingMoviesNotifier extends _i1.Mock
    implements _i3.NowPlayingMoviesNotifier {
  MockNowPlayingMoviesNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetNowPlayingMovies get getNowPlayingMovies =>
      (super.noSuchMethod(Invocation.getter(#getNowPlayingMovies),
          returnValue: _FakeGetNowPlayingMovies()) as _i2.GetNowPlayingMovies);
  @override
  _i4.RequestState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i4.RequestState.empty) as _i4.RequestState);
  @override
  List<_i5.Movie> get movies => (super.noSuchMethod(Invocation.getter(#movies),
      returnValue: <_i5.Movie>[]) as List<_i5.Movie>);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i6.Future<void> fetchNowPlayingMovies() =>
      (super.noSuchMethod(Invocation.method(#fetchNowPlayingMovies, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
