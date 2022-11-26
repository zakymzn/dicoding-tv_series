import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/crew_in_episode_detail_model.dart';
import 'package:tv_series/data/models/guest_star_model.dart';

class TvEpisodeDetail extends Equatable {
  TvEpisodeDetail({
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

  String airDate;
  List<CrewInEpisodeDetailModel> crew;
  int episodeNumber;
  List<GuestStarModel> guestStars;
  String name;
  String overview;
  int id;
  int seasonNumber;
  String? stillPath;
  double voteAverage;
  int voteCount;

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
