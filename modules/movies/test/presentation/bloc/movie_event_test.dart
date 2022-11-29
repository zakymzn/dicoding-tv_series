import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/movie_dummy_objects.dart';

void main() {
  test(
    'test movie event',
    () async {
      expect(OnNowPlayingMovies(), OnNowPlayingMovies());
      expect(OnPopularMovies(), OnPopularMovies());
      expect(OnTopRatedMovies(), OnTopRatedMovies());
      expect(const OnMovieRecommendations(557),
          OnMovieRecommendations(testMovieList.first.id));
      expect(const OnMovieDetail(1), OnMovieDetail(testMovieDetail.id));
      expect(OnMovieWatchlist(), OnMovieWatchlist());
      expect(const OnMovieWatchlistStatus(1),
          OnMovieWatchlistStatus(testMovieDetail.id));
      expect(OnAddMovieWatchlist(testMovieDetail),
          const OnAddMovieWatchlist(testMovieDetail));
      expect(OnRemoveMovieWatchlist(testMovieDetail),
          const OnRemoveMovieWatchlist(testMovieDetail));
    },
  );
}
