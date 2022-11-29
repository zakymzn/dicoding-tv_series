import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

class TvSeasonDetailResponse extends Equatable {
  const TvSeasonDetailResponse({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.seasonDetailId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final String? airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int seasonDetailId;
  final String? posterPath;
  final int seasonNumber;

  factory TvSeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvSeasonDetailResponse(
        id: json["_id"],
        airDate: json["air_date"],
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        seasonDetailId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  TvSeasonDetail toEntity() {
    return TvSeasonDetail(
      id: id,
      airDate: airDate,
      episodes: episodes,
      name: name,
      overview: overview,
      seasonDetailId: seasonDetailId,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
    );
  }

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
