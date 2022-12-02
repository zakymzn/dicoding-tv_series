import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

class TvEpisodeDetailResponse extends Equatable {
  const TvEpisodeDetailResponse({
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

  final String airDate;
  final List<CrewInEpisodeDetailModel> crew;
  final int episodeNumber;
  final List<GuestStarModel> guestStars;
  final String name;
  final String overview;
  final int id;
  final String? productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

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

  TvEpisodeDetail toEntity() {
    return TvEpisodeDetail(
      airDate: airDate,
      crew: crew.map((e) => e.toEntity()).toList(),
      episodeNumber: episodeNumber,
      guestStars: guestStars.map((e) => e.toEntity()).toList(),
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
