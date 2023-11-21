import 'package:practica_final_3/models/models.dart';

class ArtistAlbum {
  String name;
  String url;

  ArtistAlbum({
    required this.name,
    required this.url,
  });

  factory ArtistAlbum.fromRawJson(String str) =>
      ArtistAlbum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArtistAlbum.fromJson(Map<String, dynamic> json) => ArtistAlbum(
        name: json["name"] ?? '',
        url: json["url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
