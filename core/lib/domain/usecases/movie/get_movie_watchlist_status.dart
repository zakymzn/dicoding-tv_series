import 'package:core/core.dart';

class GetMovieWatchListStatus {
  final MovieRepository repository;

  GetMovieWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
