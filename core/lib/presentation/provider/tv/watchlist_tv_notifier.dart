import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTv = <Tv>[];
  List<Tv> get watchlistTv => _watchlistTv;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchListTv});

  final GetWatchlistTv getWatchListTv;

  Future<void> fetchWatchlistTv() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchListTv.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = RequestState.loaded;
        _watchlistTv = tvData;
        notifyListeners();
      },
    );
  }
}
