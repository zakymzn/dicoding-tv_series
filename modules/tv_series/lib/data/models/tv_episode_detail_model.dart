import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_episode_detail.dart';

import 'crew_in_episode_detail_model.dart';
import 'guest_star_model.dart';

class TvEpisodeDetailResponse extends Equatable {
  TvEpisodeDetailResponse({
    required this.airDate,
    required this.crew,
    required this.episodeNumber,
    required this.guestStars,
    required this.name,
    required this.overview,
    required this.id,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  String airDate;
  List<CrewInEpisodeDetailModel> crew;
  int episodeNumber;
  List<GuestStarModel> guestStars;
  String name;
  String overview;
  int id;
  String? productionCode;
  int seasonNumber;
  String? stillPath;
  double voteAverage;
  int voteCount;

  factory TvEpisodeDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvEpisodeDetailResponse(
        airDate: json["air_date"],
        crew: List<CrewInEpisodeDetailModel>.from(
            json["crew"].map((x) => CrewInEpisodeDetailModel.fromJson(x))),
        episodeNumber: json["episode_number"],
        guestStars: List<GuestStarModel>.from(
            json["guest_stars"].map((x) => GuestStarModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
        "episode_number": episodeNumber,
        "guest_stars": List<dynamic>.from(guestStars.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": id,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TvEpisodeDetail toEntity() {
    return TvEpisodeDetail(
      airDate: airDate,
      crew: crew,
      episodeNumber: episodeNumber,
      guestStars: guestStars,
      name: name,
      overview: overview,
      id: id,
      seasonNumber: seasonNumber,
      stillPath: stillPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        crew,
        episodeNumber,
        guestStars,
        name,
        overview,
        id,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
