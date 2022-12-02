import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  final tTvEpisodeDetailModel = TvEpisodeDetailResponse(
    airDate: 'airDate',
    crew: const [
      CrewInEpisodeDetailModel(
        id: 1,
        creditId: 'creditId',
        name: 'name',
        department: 'department',
        job: 'job',
        profilePath: 'profilePath',
      ),
    ],
    episodeNumber: 1,
    guestStars: const [
      GuestStarModel(
        id: 1,
        name: 'name',
        creditId: 'creditId',
        character: 'character',
        order: 1,
        profilePath: 'profilePath',
      ),
    ],
    name: 'name',
    overview: 'overview',
    id: 1,
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvEpisodeDetail = TvEpisodeDetail(
    airDate: 'airDate',
    crew: [
      CrewInEpisodeDetail(
        id: 1,
        creditId: 'creditId',
        name: 'name',
        department: 'department',
        job: 'job',
        profilePath: 'profilePath',
      ),
    ],
    episodeNumber: 1,
    guestStars: [
      GuestStar(
        id: 1,
        name: 'name',
        creditId: 'creditId',
        character: 'character',
        order: 1,
        profilePath: 'profilePath',
      ),
    ],
    name: 'name',
    overview: 'overview',
    id: 1,
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test(
    'should be a subclass of Tv Episode Detail entity',
    () async {
      final result = tTvEpisodeDetailModel.toEntity();
      expect(result, tTvEpisodeDetail);
    },
  );
}
