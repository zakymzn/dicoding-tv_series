import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/crew_in_episode_detail_model.dart';
import 'package:tv_series/data/models/guest_star_model.dart';
import 'package:tv_series/data/models/tv_episode_detail_model.dart';
import 'package:tv_series/domain/entities/tv_episode_detail.dart';

void main() {
  final tTvEpisodeDetailModel = TvEpisodeDetailResponse(
    airDate: 'airDate',
    crew: [
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
    guestStars: [
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
    guestStars: [
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
