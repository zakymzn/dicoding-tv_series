import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

class GetTvSeasonDetail {
  final TvRepository repository;

  GetTvSeasonDetail(this.repository);

  Future<Either<Failure, TvSeasonDetail>> execute(int id, int seasonNumber) {
    return repository.getTvSeasonDetail(id, seasonNumber);
  }
}
