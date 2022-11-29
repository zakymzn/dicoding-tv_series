import 'package:core/data/models/genre_model.dart';
import 'package:equatable/equatable.dart';

class GenreResponse extends Equatable {
  final List<GenreModel> genreList;

  const GenreResponse({required this.genreList});

  factory GenreResponse.fromJson(Map<String, dynamic> json) => GenreResponse(
      genreList: List<GenreModel>.from(
          (json["genres"] as List).map((e) => GenreModel.fromJson(e))));

  @override
  List<Object?> get props => [genreList];
}
