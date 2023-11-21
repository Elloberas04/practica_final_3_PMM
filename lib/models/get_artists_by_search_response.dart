import 'package:practica_final_3/models/models.dart';

/*Per mapejar la resposta quan demanam a la API una llista d'artistes a traves del cercador.*/
class GetArtistsBySearchResponse {
  List<Artist> artists;

  GetArtistsBySearchResponse({
    required this.artists,
  });

  factory GetArtistsBySearchResponse.fromRawJson(String str) =>
      GetArtistsBySearchResponse.fromJson(json.decode(str));

  factory GetArtistsBySearchResponse.fromJson(Map<String, dynamic> json) {
    final artistMatches = json['results']['artistmatches'];
    final List<dynamic> artistList = artistMatches['artist'];

    return GetArtistsBySearchResponse(
      artists: List<Artist>.from(artistList.map((x) => Artist.fromJson(x))),
    );
  }
}

class Artist {
  String name;
  String listeners;
  String mbid;
  String url;
  String streamable;
  List<ImageAlbum> image;

  Artist({
    required this.name,
    required this.listeners,
    required this.mbid,
    required this.url,
    required this.streamable,
    required this.image,
  });

  factory Artist.fromRawJson(String str) => Artist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        name: json["name"],
        listeners: json["listeners"],
        mbid: json["mbid"],
        url: json["url"],
        streamable: json["streamable"],
        image: List<ImageAlbum>.from(
            json["image"].map((x) => ImageAlbum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "listeners": listeners,
        "mbid": mbid,
        "url": url,
        "streamable": streamable,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
      };
}
