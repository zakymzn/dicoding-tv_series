import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movies/movies.dart';

class RemoveMovieWatchlist {
  final MovieRepository repository;

  RemoveMovieWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
