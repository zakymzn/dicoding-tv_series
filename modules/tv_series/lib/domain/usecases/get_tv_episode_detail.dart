import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

class GetTvEpisodeDetail {
  final TvRepository repository;

  GetTvEpisodeDetail(this.repository);

  Future<Either<Failure, TvEpisodeDetail>> execute(
      int id, int seasonNumber, int episodeNumber) {
    return repository.getTvEpisodeDetail(id, seasonNumber, episodeNumber);
  }
}
