import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
