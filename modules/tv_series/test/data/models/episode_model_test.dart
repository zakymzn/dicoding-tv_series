import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/crew_in_season_detail_model.dart';
import 'package:tv_series/data/models/episode_model.dart';
import 'package:tv_series/domain/entities/crew_in_season_detail.dart';
import 'package:tv_series/domain/entities/episode.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
    airDate: 'airDate',
    episodeNumber: 1,
    crew: [
      CrewInSeasonDetailModel(
        department: 'department',
        job: 'job',
        creditId: 'creditId',
        adult: true,
        gender: 1,
        id: 1,
        knownForDepartment: 'knownForDepartment',
        name: 'name',
        originalName: 'originalName',
        popularity: 1,
        profilePath: 'profilePath',
        order: 1,
        character: 'character',
      ),
    ],
    guestStars: [
      CrewInSeasonDetailModel(
        department: 'department',
        job: 'job',
        creditId: 'creditId',
        adult: true,
        gender: 1,
        id: 1,
        knownForDepartment: 'knownForDepartment',
        name: 'name',
        originalName: 'originalName',
        popularity: 1,
        profilePath: 'profilePath',
        order: 1,
        character: 'character',
      ),
    ],
    id: 1,
    name: 'name',
    overview: 'overview',
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tEpisode = Episode(
    airDate: 'airDate',
    episodeNumber: 1,
    crew: [
      CrewInSeasonDetail(
        department: 'department',
        job: 'job',
        creditId: 'creditId',
        adult: true,
        id: 1,
        knownForDepartment: 'knownForDepartment',
        originalName: 'originalName',
        popularity: 1,
        profilePath: 'profilePath',
        character: 'character',
      )
    ],
    guestStars: [
      CrewInSeasonDetail(
        department: 'department',
        job: 'job',
        creditId: 'creditId',
        adult: true,
        id: 1,
        knownForDepartment: 'knownForDepartment',
        originalName: 'originalName',
        popularity: 1,
        profilePath: 'profilePath',
        character: 'character',
      )
    ],
    id: 1,
    name: 'name',
    overview: 'overview',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test(
    'should be a subclass of Episode entity',
    () async {
      final result = tEpisodeModel.toEntity();
      expect(result, tEpisode);
    },
  );
}
