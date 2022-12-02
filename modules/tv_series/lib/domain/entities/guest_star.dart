import 'package:equatable/equatable.dart';

class GuestStar extends Equatable {
  GuestStar({
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
