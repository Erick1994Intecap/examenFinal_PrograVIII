import 'dart:convert';

class Cast {
  Cast(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.name,
      required this.originalName,
      required this.profilePath});

  bool adult;
  int? gender;
  int id;
  String name;
  String originalName;
  String profilePath;

  factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        name: json["name"],
        originalName: json["original_name"],
        profilePath: json["profile_path"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "name": name,
        "original_name": originalName,
        "profile_path": profilePath,
      };
}
