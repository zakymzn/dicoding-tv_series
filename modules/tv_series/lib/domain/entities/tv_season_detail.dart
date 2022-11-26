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
  String? airDate;
  List<EpisodeModel> episodes;
  String name;
  String overview;
  int seasonDetailId;
  String? posterPath;
  int seasonNumber;

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
