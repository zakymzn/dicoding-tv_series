import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/episode_model.dart';

class TvSeasonDetail extends Equatable {
  TvSeasonDetail({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonDetailId,
    required this.posterPath,
    required this.seasonNumber,
  });

  String id;
  DateTime airDate;
  List<EpisodeModel> episodes;
  String name;
  String overview;
  int seasonDetailId;
  String? posterPath;
  int seasonNumber;

  factory TvSeasonDetail.fromJson(Map<String, dynamic> json) => TvSeasonDetail(
        id: json["_id"],
        airDate: DateTime.parse(json["air_date"]),
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonDetailId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": seasonDetailId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        seasonDetailId,
        posterPath,
        seasonNumber,
      ];
}
