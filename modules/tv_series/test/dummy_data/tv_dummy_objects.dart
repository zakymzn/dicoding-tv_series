import 'package:core/domain/entities/genre.dart';
import 'package:tv_series/tv_series.dart';

final testTv = Tv(
  posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
  popularity: 47.432451,
  id: 31917,
  backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
  voteAverage: 5.04,
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  firstAirDate: "2010-06-08",
  originCountry: const ["US"],
  genreIds: const [18, 9648],
  originalLanguage: "en",
  voteCount: 133,
  name: "Pretty Little Liars",
  originalName: "Pretty Little Liars",
);

final testTvList = [testTv];

const testTvDetail = TvDetail(
  backdropPath: "backdropPath",
  lastEpisodeToAir: LastEpisodeToAirModel(
    airDate: "airDate",
    episodeNumber: 1,
    id: 1,
    name: "name",
    overview: "overview",
    runtime: 1,
    seasonNumber: 1,
    voteAverage: 1,
    voteCount: 1,
    productionCode: 'productionCode',
    stillPath: 'stillPath',
  ),
  name: "name",
  episodeRunTime: [1],
  firstAirDate: "firstAirDate",
  nextEpisodeToAir: 1,
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ["originCountry"],
  genres: [
    Genre(id: 1, name: "name"),
  ],
  seasons: [
    SeasonModel(
        airDate: "airDate",
        episodeCount: 1,
        id: 1,
        name: "name",
        overview: "overview",
        posterPath: "posterPath",
        seasonNumber: 1)
  ],
  id: 1,
  originalName: "originalName",
  overview: "overview",
  posterPath: "posterPath",
  voteAverage: 1,
  voteCount: 1,
);

final testTvSeasonDetail = TvSeasonDetail(
  id: 'id',
  airDate: 'airDate',
  episodes: [
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
        voteCount: 1)
  ],
  name: 'name',
  overview: 'overview',
  seasonDetailId: 1,
  posterPath: 'posterPath',
  seasonNumber: 1,
);

final testTvEpisodeDetail = TvEpisodeDetail(
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

final testWatchlistTv = Tv.watchlist(
  id: 1,
  overview: "overview",
  posterPath: "posterPath",
  name: "name",
);

const testTvTable = TvTable(
  id: 1,
  name: "name",
  posterPath: "posterPath",
  overview: "overview",
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
