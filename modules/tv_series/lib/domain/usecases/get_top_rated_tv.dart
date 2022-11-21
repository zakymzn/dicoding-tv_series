import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';

class GetTopRatedTv {
  final TvRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTv();
  }
}
