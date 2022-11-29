import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/episode_model.dart';

class TvSeasonDetail extends Equatable {
  const TvSeasonDetail({
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
