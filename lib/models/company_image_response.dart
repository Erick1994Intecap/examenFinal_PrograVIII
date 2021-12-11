import 'dart:convert';

import 'logo.dart';

class CompanyImageResponse {
  CompanyImageResponse({
    required this.id,
    required this.logos,
  });

  List<Logo> logos;
  int id;

  factory CompanyImageResponse.fromJson(String str) =>
      CompanyImageResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanyImageResponse.fromMap(Map<String, dynamic> json) =>
      CompanyImageResponse(
        id: json["id"],
        logos: List<Logo>.from(json["logos"].map((x) => Logo.fromMap(x))),
      );

  Map<String, dynamic> toMap() =>
      {"id": id, "logos": List<dynamic>.from(logos.map((x) => x.toMap()))};
}
