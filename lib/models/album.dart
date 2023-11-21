import 'package:practica_final_3/models/models.dart';

class Album {
  String name;
  int playcount;
  String url;
  ArtistAlbum artist;
  List<ImageAlbum> image;

  Album({
    required this.name,
    required this.playcount,
    required this.url,
    required this.artist,
    required this.image,
  });

  factory Album.fromRawJson(String str) => Album.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        name: json["name"] ?? '',
        playcount: json["playcount"] ?? 0,
        url: json["url"] ?? '',
        artist: ArtistAlbum.fromJson(json["artist"]),
        image: List<ImageAlbum>.from(
            json["image"].map((x) => ImageAlbum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "playcount": playcount,
        "url": url,
        "artist": artist.toJson(),
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };
}
