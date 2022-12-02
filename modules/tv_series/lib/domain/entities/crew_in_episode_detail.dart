import 'package:equatable/equatable.dart';

class CrewInEpisodeDetail extends Equatable {
  CrewInEpisodeDetail({
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
