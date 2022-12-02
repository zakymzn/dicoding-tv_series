import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

class Episode extends Equatable {
  Episode({
    required this.airDate,
    required this.episodeNumber,
    required this.crew,
    required this.guestStars,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  String airDate;
  int episodeNumber;
  List<CrewInSeasonDetail> crew;
  List<CrewInSeasonDetail> guestStars;
  int id;
  String name;
  String overview;
  int seasonNumber;
  String? stillPath;
  double voteAverage;
  int voteCount;

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        crew,
        guestStars,
        id,
        name,
        overview,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
