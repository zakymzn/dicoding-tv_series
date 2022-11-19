import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

class SearchTv {
  final TvRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTv(query);
  }
}
