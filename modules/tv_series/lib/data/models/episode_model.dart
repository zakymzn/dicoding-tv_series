import 'package:equatable/equatable.dart';

import 'crew_in_season_detail_model.dart';

class EpisodeModel extends Equatable {
  const EpisodeModel({
    required this.airDate,
    required this.episodeNumber,
    required this.crew,
    required this.guestStars,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String airDate;
  final int episodeNumber;
  final List<CrewInSeasonDetailModel> crew;
  final List<CrewInSeasonDetailModel> guestStars;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        crew: List<CrewInSeasonDetailModel>.from(
            json["crew"].map((x) => CrewInSeasonDetailModel.fromJson(x))),
        guestStars: List<CrewInSeasonDetailModel>.from(json["guest_stars"]
            .map((x) => CrewInSeasonDetailModel.fromJson(x))),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        crew,
        guestStars,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
