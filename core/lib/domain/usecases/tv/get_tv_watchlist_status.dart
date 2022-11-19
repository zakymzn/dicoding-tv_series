import 'package:core/core.dart';

class GetTvWatchListStatus {
  final TvRepository repository;

  GetTvWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
