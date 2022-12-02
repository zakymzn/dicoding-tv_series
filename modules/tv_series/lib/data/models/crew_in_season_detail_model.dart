import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

class CrewInSeasonDetailModel extends Equatable {
  const CrewInSeasonDetailModel({
    required this.department,
    required this.job,
    required this.creditId,
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.order,
    required this.character,
  });

  final String? department;
  final String? job;
  final String creditId;
  final bool? adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? order;
  final String? character;

  factory CrewInSeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      CrewInSeasonDetailModel(
        department: json["department"],
        job: json["job"],
        creditId: json["credit_id"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"],
        profilePath: json["profile_path"],
        order: json["order"],
        character: json["character"],
      );

  CrewInSeasonDetail toEntity() {
    return CrewInSeasonDetail(
      department: department,
      job: job,
      creditId: creditId,
      adult: adult,
      id: id,
      knownForDepartment: knownForDepartment,
      originalName: originalName,
      popularity: popularity,
      profilePath: profilePath,
      character: character,
    );
  }

  @override
  List<Object?> get props => [
        department,
        job,
        creditId,
        adult,
        gender,
        id,
        knownForDepartment,
        name,
        originalName,
        popularity,
        profilePath,
        order,
        character,
      ];
}
