import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

final testTv = Tv(
  posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
  popularity: 47.432451,
  id: 31917,
  backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
  voteAverage: 5.04,
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  firstAirDate: DateTime.tryParse("2010-06-08"),
  originCountry: ["US"],
  genreIds: [18, 9648],
  originalLanguage: "en",
  voteCount: 133,
  name: "Pretty Little Liars",
  originalName: "Pretty Little Liars",
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: "/ypLoTftyF5EpGBxJas4PThIdiU4.jpg",
  lastEpisodeToAir: LastEpisodeToAir(
    airDate: DateTime.tryParse("2017-06-27")!,
    episodeNumber: 20,
    id: 1328760,
    name: "Til DeAth Do Us PArt",
    overview: "All is revealed as the ultimate endgame comes to light.",
    runtime: 41,
    seasonNumber: 7,
    voteAverage: 6.7,
    voteCount: 3,
  ),
  name: "Pretty Little Liars",
  episodeRunTime: [41],
  firstAirDate: DateTime.tryParse("2010-06-08")!,
  nextEpisodeToAir: null,
  numberOfEpisodes: 161,
  numberOfSeasons: 7,
  originCountry: ["US"],
  genres: [
    Genre(id: 18, name: "Drama"),
    Genre(id: 9648, name: "Mystery"),
  ],
  seasons: [
    Season(
        airDate: DateTime.tryParse("2012-08-28")!,
        episodeCount: 11,
        id: 43395,
        name: "Specials",
        overview: "",
        posterPath: "/6Qt6NIlWxxuiNLsd9H9WxjWFmi8.jpg",
        seasonNumber: 0)
  ],
  id: 31917,
  originalName: "Pretty Little Liars",
  overview:
      "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
  posterPath: "/aUPbHiLS3hCHKjtLsncFa9g0viV.jpg",
  voteAverage: 8.031,
  voteCount: 2249,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  overview: "overview",
  posterPath: "posterPath",
  name: "name",
);

final testTvTable = TvTable(
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
