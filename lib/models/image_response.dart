import 'dart:convert';

import 'models.dart';

class ImagesResponse {
  ImagesResponse({
    required this.id,
    required this.backdrops,
  });

  int id;
  List<Images> backdrops;

  factory ImagesResponse.fromJson(String str) =>
      ImagesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImagesResponse.fromMap(Map<String, dynamic> json) => ImagesResponse(
        id: json["id"],
        backdrops:
            List<Images>.from(json["backdrops"].map((x) => Images.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "backdrops": List<dynamic>.from(backdrops.map((x) => x.toMap())),
      };
}
