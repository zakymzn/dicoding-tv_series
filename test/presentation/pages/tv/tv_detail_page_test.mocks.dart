import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:ditonton/common/state_enum.dart' as _i9;
import 'package:ditonton/domain/entities/tv/tv.dart' as _i10;
import 'package:ditonton/domain/entities/tv/tv_detail.dart' as _i7;
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart' as _i2;
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart' as _i3;
import 'package:ditonton/domain/usecases/tv/get_tv_watchlist_status.dart'
    as _i4;
import 'package:ditonton/domain/usecases/tv/remove_tv_watchlist.dart' as _i6;
import 'package:ditonton/domain/usecases/tv/save_tv_watchlist.dart' as _i5;
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

class _FakeGetTvDetail extends _i1.Fake implements _i2.GetTvDetail {}

class _FakeGetTvRecommendations extends _i1.Fake
    implements _i3.GetTvRecommendations {}

class _FakeGetWatchListStatus extends _i1.Fake
    implements _i4.GetTvWatchListStatus {}

class _FakeSaveWatchlist extends _i1.Fake implements _i5.SaveTvWatchlist {}

class _FakeRemoveWatchlist extends _i1.Fake implements _i6.RemoveTvWatchlist {}

class _FakeTvDetail extends _i1.Fake implements _i7.TvDetail {}

class MockTvDetailNotifier extends _i1.Mock implements _i8.TvDetailNotifier {
  MockTvDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvDetail get getTvDetail =>
      (super.noSuchMethod(Invocation.getter(#getTvDetail),
          returnValue: _FakeGetTvDetail()) as _i2.GetTvDetail);
  @override
  _i3.GetTvRecommendations get getTvRecommendations => (super.noSuchMethod(
      Invocation.getter(#getTvRecommendations),
      returnValue: _FakeGetTvRecommendations()) as _i3.GetTvRecommendations);
  @override
  _i4.GetTvWatchListStatus get getTvWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
          returnValue: _FakeGetWatchListStatus()) as _i4.GetTvWatchListStatus);
  @override
  _i5.SaveTvWatchlist get saveTvWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
          returnValue: _FakeSaveWatchlist()) as _i5.SaveTvWatchlist);
  @override
  _i6.RemoveTvWatchlist get removeTvWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlist),
          returnValue: _FakeRemoveWatchlist()) as _i6.RemoveTvWatchlist);
  @override
  _i7.TvDetail get tv =>
      (super.noSuchMethod(Invocation.getter(#Tv), returnValue: _FakeTvDetail())
          as _i7.TvDetail);
  @override
  _i9.RequestState get tvState =>
      (super.noSuchMethod(Invocation.getter(#TvState),
          returnValue: _i9.RequestState.empty) as _i9.RequestState);
  @override
  List<_i10.Tv> get tvRecommendations =>
      (super.noSuchMethod(Invocation.getter(#TvRecommendations),
          returnValue: <_i10.Tv>[]) as List<_i10.Tv>);
  @override
  _i9.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: _i9.RequestState.empty) as _i9.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  bool get isAddedToWatchlist =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlist),
          returnValue: false) as bool);
  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i11.Future<void> fetchTvDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#fetchTvDetail, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> addWatchlist(_i7.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [tv]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> removeFromWatchlist(_i7.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#removeFromWatchlist, [tv]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> loadTvWatchlistStatus(int? id) =>
      (super.noSuchMethod(Invocation.method(#loadWatchlistStatus, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  void addListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i12.VoidCallback? listener) =>
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
