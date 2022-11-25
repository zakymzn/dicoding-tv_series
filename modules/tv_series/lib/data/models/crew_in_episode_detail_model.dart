import 'package:equatable/equatable.dart';

class CrewInEpisodeDetailModel extends Equatable {
  CrewInEpisodeDetailModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.department,
    required this.job,
    required this.profilePath,
  });

  int id;
  String creditId;
  String name;
  String department;
  String job;
  String? profilePath;

  factory CrewInEpisodeDetailModel.fromJson(Map<String, dynamic> json) =>
      CrewInEpisodeDetailModel(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        department: json["department"],
        job: json["job"],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "department": department,
        "job": job,
        "profile_path": profilePath == null ? null : profilePath,
      };

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
