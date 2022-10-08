import 'package:equatable/equatable.dart';

class CreatedBy extends Equatable {
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  final int id;
  final String? creditId;
  final String? name;
  final int? gender;
  final dynamic? profilePath;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        creditId,
        name,
        gender,
        profilePath,
      ];
}
