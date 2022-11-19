import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class GetNowPlayingTv {
  final TvRepository repository;

  GetNowPlayingTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTv();
  }
}
