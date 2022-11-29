import 'package:equatable/equatable.dart';

class CrewInEpisodeDetailModel extends Equatable {
  const CrewInEpisodeDetailModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.department,
    required this.job,
    required this.profilePath,
  });

  final int id;
  final String creditId;
  final String name;
  final String department;
  final String job;
  final String? profilePath;

  factory CrewInEpisodeDetailModel.fromJson(Map<String, dynamic> json) =>
      CrewInEpisodeDetailModel(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        department: json["department"],
        job: json["job"],
        profilePath: json["profile_path"],
      );

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        department,
        job,
        profilePath,
      ];
}
