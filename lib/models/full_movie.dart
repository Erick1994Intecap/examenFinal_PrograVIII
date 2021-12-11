import 'dart:convert';

import 'package:cartelera/models/production_companies.dart';

class MovieF {
  MovieF({
    required this.id,
    required this.originalTitle,
    required this.productionCompanies,
  });

  List<Companies> productionCompanies;
  int id;
  String originalTitle;

  factory MovieF.fromJson(String str) => MovieF.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieF.fromMap(Map<String, dynamic> json) => MovieF(
        id: json["id"],
        originalTitle: json["original_title"],
        productionCompanies: List<Companies>.from(
            json["production_companies"].map((x) => Companies.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "original_title": originalTitle,
        "production_companies":
            List<dynamic>.from(productionCompanies.map((x) => x.toMap()))
      };
}
