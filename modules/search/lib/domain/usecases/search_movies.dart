import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movies/movies.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
