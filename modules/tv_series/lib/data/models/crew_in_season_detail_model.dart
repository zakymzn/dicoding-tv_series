import 'package:equatable/equatable.dart';

class CrewInSeasonDetailModel extends Equatable {
  CrewInSeasonDetailModel({
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

  String? department;
  String? job;
  String creditId;
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? order;
  String? character;

  factory CrewInSeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      CrewInSeasonDetailModel(
        department: json["department"] == null ? null : json["department"],
        job: json["job"] == null ? null : json["job"],
        creditId: json["credit_id"],
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"],
        profilePath: json["profile_path"] == null ? null : json["profile_path"],
        order: json["order"] == null ? null : json["order"],
        character: json["character"] == null ? null : json["character"],
      );

  Map<String, dynamic> toJson() => {
        "department": department == null ? null : department,
        "job": job == null ? null : job,
        "credit_id": creditId,
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath == null ? null : profilePath,
        "order": order == null ? null : order,
        "character": character == null ? null : character,
      };

  @override
  // TODO: implement props
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
