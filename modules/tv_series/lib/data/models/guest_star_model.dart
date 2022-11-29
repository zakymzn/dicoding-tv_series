import 'package:equatable/equatable.dart';

class GuestStarModel extends Equatable {
  const GuestStarModel({
    required this.id,
    required this.name,
    required this.creditId,
    required this.character,
    required this.order,
    required this.profilePath,
  });

  final int id;
  final String name;
  final String creditId;
  final String character;
  final int order;
  final String? profilePath;

  factory GuestStarModel.fromJson(Map<String, dynamic> json) => GuestStarModel(
        id: json["id"],
        name: json["name"],
        creditId: json["credit_id"],
        character: json["character"],
        order: json["order"],
        profilePath: json["profile_path"],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        creditId,
        character,
        order,
        profilePath,
      ];
}
