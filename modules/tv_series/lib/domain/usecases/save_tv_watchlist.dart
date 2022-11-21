import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

class SaveTvWatchlist {
  final TvRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchlist(tv);
  }
}
