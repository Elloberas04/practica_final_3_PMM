import 'package:practica_final_3/models/models.dart';

class Tags {
  List<Tag> tags;

  Tags({
    required this.tags,
  });

  // factory Tags.fromRawJson(String str) => Tags.fromJson(json.decode(str));

  // factory Tags.fromJson(Map<String, dynamic> json) => Tags(
  //       tags: List<Tag>.from(json["tag"].map((x) => Tag.fromJson(x))),
  //     );

  factory Tags.fromRawJson(String str) {
    final jsonData = json.decode(str);
    dynamic tagData = jsonData['tag'] ?? jsonData['tags'] ?? [];

    return Tags(
      tags: (tagData is List)
          ? List<Tag>.from(tagData.map((x) => Tag.fromJson(x)))
          : (tagData is Map && tagData['tag'] != null)
              ? [Tag.fromJson(tagData['tag'])]
              : [],
    );
  }

  factory Tags.fromJson(Map<String, dynamic> json) {
    dynamic tagData = json['tag'] ?? json['tags'] ?? [];

    return Tags(
      tags: (tagData is List)
          ? List<Tag>.from(tagData.map((x) => Tag.fromJson(x)))
          : (tagData is Map && tagData['tag'] != null)
              ? [Tag.fromJson(tagData['tag'])]
              : [],
    );
  }

  factory Tags.empty() {
    return Tags(tags: []);
  }
}

class Tag {
  String name;
  String url;

  Tag({
    required this.name,
    required this.url,
  });

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"] ?? '',
        url: json["url"] ?? '',
      );
}
