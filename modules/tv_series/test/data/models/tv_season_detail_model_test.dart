import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  final tTvSeasonDetailModel = TvSeasonDetailResponse(
    id: 'id',
    airDate: 'airDate',
    episodes: const [
      EpisodeModel(
        airDate: 'airDate',
        episodeNumber: 1,
        crew: [
          CrewInSeasonDetailModel(
            department: 'department',
            job: 'job',
            creditId: 'creditId',
            adult: false,
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
            adult: false,
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
      ),
    ],
    name: 'name',
    overview: 'overview',
    seasonDetailId: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tTvSeasonDetail = TvSeasonDetail(
    id: 'id',
    airDate: 'airDate',
    episodes: [
      Episode(
        airDate: 'airDate',
        episodeNumber: 1,
        crew: [
          CrewInSeasonDetail(
            department: 'department',
            job: 'job',
            creditId: 'creditId',
            adult: false,
            id: 1,
            knownForDepartment: 'knownForDepartment',
            originalName: 'originalName',
            popularity: 1,
            profilePath: 'profilePath',
            character: 'character',
          ),
        ],
        guestStars: [
          CrewInSeasonDetail(
            department: 'department',
            job: 'job',
            creditId: 'creditId',
            adult: false,
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
      ),
    ],
    name: 'name',
    overview: 'overview',
    seasonDetailId: 1,
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test(
    'should be a subclass of Tv Season Detail entity',
    () async {
      final result = tTvSeasonDetailModel.toEntity();
      expect(result, tTvSeasonDetail);
    },
  );
}
