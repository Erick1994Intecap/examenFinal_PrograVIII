import 'dart:convert';

class Logo {
  Logo({
    required this.filePath,
    required this.id,
  });

  String filePath;
  String id;

  factory Logo.fromJson(String str) => Logo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Logo.fromMap(Map<String, dynamic> json) =>
      Logo(filePath: json["file_path"] ?? '', id: json["id"]);

  Map<String, dynamic> toMap() => {"file_path": filePath, "id": id};
}
