import 'dart:convert';

List<GenresModel> genresFromJson(
  String str,
) => List<GenresModel>.from(
  json.decode(str).map((x) => GenresModel.fromJson(x)),
);

String genresToJson(
  List<GenresModel> data,
) => json.encode(
  List<dynamic>.from(data.map((x) => x.toJson())),
);

class GenresModel {
  GenresModel({
    required this.id,
    required this.name,
    this.parentId,
  });

  int id;
  String name;
  int? parentId;

  factory GenresModel.fromJson(
    Map<String, dynamic> json,
  ) => GenresModel(
    id: json["id"],
    name: json["name"],
    parentId: json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent_id": parentId,
  };
}
