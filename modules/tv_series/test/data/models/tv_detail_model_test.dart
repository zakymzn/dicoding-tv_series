import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/created_by_model.dart';
import 'package:tv_series/data/models/last_episode_to_air_model.dart';
import 'package:tv_series/data/models/season_model.dart';
import 'package:tv_series/data/models/tv_detail_model.dart';
import 'package:tv_series/domain/entities/last_episode_to_air.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';

void main() {
  final tTvDetailModel = TvDetailResponse(
    backdropPath: 'backdropPath',
    createdBy: const [
      CreatedByModel(
          id: 1,
          creditId: 'creditId',
          name: 'name',
          gender: 1,
          profilePath: 'profilePath'),
    ],
    episodeRunTime: const [1],
    firstAirDate: 'firstAirDate',
    genres: const [
      GenreModel(id: 1, name: 'name'),
    ],
    homepage: 'homepage',
    id: 1,
    inProduction: true,
    languages: const ['languages'],
    lastAirDate: 'lastAirDate',
    lastEpisodeToAir: LastEpisodeToAirModel(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1,
    ),
    name: 'name',
    nextEpisodeToAir: 1,
    networks: const ['networks'],
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: const ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    productionCompanies: const ['productionCompanies'],
    productionCountries: const ['productionCountries'],
    seasons: const [
      SeasonModel(
          airDate: 'airDate',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1),
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvDetail = TvDetail(
    backdropPath: 'backdropPath',
    lastEpisodeToAir: LastEpisodeToAir(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      seasonNumber: 1,
      voteAverage: 1,
      voteCount: 1,
    ),
    name: 'name',
    episodeRunTime: const [1],
    firstAirDate: 'firstAirDate',
    nextEpisodeToAir: 1,
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: const ['originCountry'],
    genres: const [
      Genre(id: 1, name: 'name'),
    ],
    seasons: const [
      Season(
          airDate: 'airDate',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1),
    ],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  test(
    'should be a subclass of Tv Detail entity',
    () async {
      final result = tTvDetailModel.toEntity();
      expect(result, tTvDetail);
    },
  );
}
