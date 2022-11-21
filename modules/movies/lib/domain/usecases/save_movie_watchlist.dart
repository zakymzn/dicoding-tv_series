import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movies/movies.dart';

class SaveMovieWatchlist {
  final MovieRepository repository;

  SaveMovieWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
