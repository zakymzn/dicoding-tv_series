import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/tv_dummy_objects.dart';

void main() {
  test(
    'test tv event',
    () async {
      expect(OnNowPlayingTv(), OnNowPlayingTv());
      expect(OnPopularTv(), OnPopularTv());
      expect(OnTopRatedTv(), OnTopRatedTv());
      expect(
          OnTvRecommendations(31917), OnTvRecommendations(testTvList.first.id));
      expect(OnTvDetail(1), OnTvDetail(testTvDetail.id));
      expect(OnTvSeasonDetail(1, 1),
          OnTvSeasonDetail(testTvDetail.id, testTvSeasonDetail.seasonNumber));
      expect(
          OnTvEpisodeDetail(1, 1, 1),
          OnTvEpisodeDetail(testTvDetail.id, testTvSeasonDetail.seasonNumber,
              testTvEpisodeDetail.episodeNumber));
      expect(OnTvWatchlist(), OnTvWatchlist());
      expect(OnTvWatchlistStatus(1), OnTvWatchlistStatus(testTvDetail.id));
      expect(OnAddTvWatchlist(testTvDetail), OnAddTvWatchlist(testTvDetail));
      expect(
          OnRemoveTvWatchlist(testTvDetail), OnRemoveTvWatchlist(testTvDetail));
    },
  );
}