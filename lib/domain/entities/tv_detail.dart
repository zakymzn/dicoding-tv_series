import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.adult,
    required this.backdropPath,
    required this.lastEpisodeToAir,
    required this.firstAirDate,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.genres,
    required this.seasons,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final LastEpisodeToAir lastEpisodeToAir;
  final DateTime firstAirDate;
  final dynamic nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<dynamic> originCountry;
  final List<Genre> genres;
  final List<Season> seasons;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final int voteAverage;
  final int voteCount;

  @override
  // TODO: implement props
  List<Object?> get props => [
        adult,
        backdropPath,
        lastEpisodeToAir,
        firstAirDate,
        nextEpisodeToAir,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        genres,
        seasons,
        id,
        originalName,
        overview,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
