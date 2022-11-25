import 'package:equatable/equatable.dart';

class GuestStarModel extends Equatable {
  GuestStarModel({
    required this.id,
    required this.name,
    required this.creditId,
    required this.character,
    required this.order,
    required this.profilePath,
  });

  int id;
  String name;
  String creditId;
  String character;
  int order;
  String? profilePath;

  factory GuestStarModel.fromJson(Map<String, dynamic> json) => GuestStarModel(
        id: json["id"],
        name: json["name"],
        creditId: json["credit_id"],
        character: json["character"],
        order: json["order"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "credit_id": creditId,
        "character": character,
        "order": order,
        "profile_path": profilePath,
      };

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
