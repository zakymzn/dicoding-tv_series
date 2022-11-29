import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/crew_in_episode_detail_model.dart';
import 'package:tv_series/data/models/guest_star_model.dart';

class TvEpisodeDetail extends Equatable {
  const TvEpisodeDetail({
    required this.airDate,
    required this.crew,
    required this.episodeNumber,
    required this.guestStars,
    required this.name,
    required this.overview,
    required this.id,
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
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        airDate,
        crew,
        episodeNumber,
        guestStars,
        name,
        overview,
        id,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
