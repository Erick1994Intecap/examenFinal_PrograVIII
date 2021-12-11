import 'dart:convert';

class Companies {
  Companies(
      {required this.logoPath,
      required this.id,
      required this.name,
      required this.description,
      required this.headquarters,
      required this.originCountry});

  String logoPath;
  int id;
  String originCountry;
  String name;
  String headquarters;
  String description;

  factory Companies.fromJson(String str) => Companies.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Companies.fromMap(Map<String, dynamic> json) => Companies(
      logoPath: json["logo_path"] ?? '',
      name: json["name"],
      description: json["description"] ?? '',
      id: json["id"],
      headquarters: json["headquarters"] ?? '',
      originCountry: json["origin_country"]);

  Map<String, dynamic> toMap() => {
        "logo_path": logoPath,
        "name": name,
        "headquarters": headquarters,
        "description": description,
        "origin_country": originCountry,
        "id": id
      };
}
