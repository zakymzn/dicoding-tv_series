import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double? popularity;
  final int id;
  final String? backdropPath;
  final double? voteAverage;
  final String? overview;
  final DateTime? firstAirDate;
  final List<String>? originCountry;
  final List<int>? genreIds;
  final String? originalLanguage;
  final int? voteCount;
  final String? name;
  final String? originalName;

  @override
  // TODO: implement props
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
