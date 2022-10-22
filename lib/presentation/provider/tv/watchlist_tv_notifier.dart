import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTv = <Tv>[];
  List<Tv> get watchlistTv => _watchlistTv;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchListTv});

  final GetWatchListTv getWatchListTv;

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchListTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTv = tvData;
        notifyListeners();
      },
    );
  }
}
