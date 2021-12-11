import 'dart:convert';

class Images {
  Images(
      {required this.filePath,
      required this.height,
      required this.width,
      required this.id,
      required this.fileISO});

  String filePath;
  int? height;
  int? width;
  int id;
  String? fileISO;

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        filePath: json["file_path"],
        height: json["height"],
        width: json["width"],
        id: json["id"] ?? 0,
        fileISO: json["iso_639_1"],
      );

  Map<String, dynamic> toMap() => {
        "file_path": filePath,
        "height": height,
        "width": width,
        "id": id,
        "iso_639_1": fileISO,
      };
}
