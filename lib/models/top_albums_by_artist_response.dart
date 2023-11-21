import 'package:practica_final_3/models/models.dart';

/*Per mapejar la resposta quan demanam a la API els albums mes top d'un artista determinat.*/
class TopAlbumsByArtistResponse {
  Topalbums topalbums;

  TopAlbumsByArtistResponse({
    required this.topalbums,
  });

  factory TopAlbumsByArtistResponse.fromRawJson(String str) =>
      TopAlbumsByArtistResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopAlbumsByArtistResponse.fromJson(Map<String, dynamic> json) =>
      TopAlbumsByArtistResponse(
        topalbums: Topalbums.fromJson(json["topalbums"]),
      );

  Map<String, dynamic> toJson() => {
        "topalbums": topalbums.toJson(),
      };
}

class Topalbums {
  List<Album> album;

  Topalbums({
    required this.album,
  });

  factory Topalbums.fromRawJson(String str) =>
      Topalbums.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Topalbums.fromJson(Map<String, dynamic> json) => Topalbums(
        album: List<Album>.from(json["album"].map((x) => Album.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "album": List<dynamic>.from(album.map((x) => x.toJson())),
      };
}
