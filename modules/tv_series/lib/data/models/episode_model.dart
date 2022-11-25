import 'package:equatable/equatable.dart';

import 'crew_in_season_detail_model.dart';

class EpisodeModel extends Equatable {
  EpisodeModel({
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

  DateTime airDate;
  int episodeNumber;
  List<CrewInSeasonDetailModel> crew;
  List<CrewInSeasonDetailModel> guestStars;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  String stillPath;
  double voteAverage;
  int voteCount;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        airDate: DateTime.parse(json["air_date"]),
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

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "guest_stars": List<dynamic>.from(guestStars.map((x) => x.toJson())),
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

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
