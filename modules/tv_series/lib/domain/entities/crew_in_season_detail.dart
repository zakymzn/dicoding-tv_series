import 'package:equatable/equatable.dart';

class CrewInSeasonDetail extends Equatable {
  CrewInSeasonDetail({
    required this.department,
    required this.job,
    required this.creditId,
    required this.adult,
    required this.id,
    required this.knownForDepartment,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.character,
  });

  String? department;
  String? job;
  String creditId;
  bool? adult;
  int id;
  String knownForDepartment;
  String originalName;
  double popularity;
  String? profilePath;
  String? character;

  @override
  List<Object?> get props => [
        department,
        job,
        creditId,
        adult,
        id,
        knownForDepartment,
        originalName,
        popularity,
        profilePath,
        character,
      ];
}
