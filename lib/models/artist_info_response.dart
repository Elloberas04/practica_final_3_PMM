import 'package:practica_final_3/models/models.dart';

/*Per mapejar la resposta quan demanam a la API l'informacio d'un artista en concret.*/
class ArtistInfoResponse {
  ArtistInfo artist;

  ArtistInfoResponse({
    required this.artist,
  });

  factory ArtistInfoResponse.fromRawJson(String str) =>
      ArtistInfoResponse.fromJson(json.decode(utf8.decode(str.codeUnits)));

  factory ArtistInfoResponse.fromJson(Map<String, dynamic> json) =>
      ArtistInfoResponse(
        artist: ArtistInfo.fromJson(json["artist"]),
      );
}

class ArtistInfo {
  String name;
  String url;
  List<Image> image;
  String listeners;
  String playcount;
  Similar similar;
  Tags tags;
  Bio bio;

  ArtistInfo({
    required this.name,
    required this.url,
    required this.image,
    required this.listeners,
    required this.playcount,
    required this.similar,
    required this.tags,
    required this.bio,
  });

  factory ArtistInfo.fromRawJson(String str) =>
      ArtistInfo.fromJson(json.decode(str));

  factory ArtistInfo.fromJson(Map<String, dynamic> json) => ArtistInfo(
        name: json["name"] ?? '',
        url: json["url"] ?? '',
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        listeners: json["stats"]["listeners"] ?? '0',
        playcount: json["stats"]["playcount"] ?? '0',
        similar: Similar.fromJson(json["similar"]),
        tags: Tags.fromJson(json["tags"]),
        bio: Bio.fromJson(json["bio"]),
      );
}

class Bio {
  String published;
  String summary;
  String content;

  Bio({
    required this.published,
    required this.summary,
    required this.content,
  });

  factory Bio.fromRawJson(String str) => Bio.fromJson(json.decode(str));

  factory Bio.fromJson(Map<String, dynamic> json) => Bio(
        published: json["published"] ?? '',
        summary: json["summary"] ?? '',
        content: json["content"] ?? '',
      );
}

class Image {
  String text;
  String size;

  Image({
    required this.text,
    required this.size,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        text: json["#text"] ?? '',
        size: json["size"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "#text": text,
        "size": size,
      };
}

class Similar {
  List<ArtistElement> artist;

  Similar({
    required this.artist,
  });

  factory Similar.fromRawJson(String str) => Similar.fromJson(json.decode(str));

  factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        artist: List<ArtistElement>.from(
            json["artist"].map((x) => ArtistElement.fromJson(x))),
      );
}

class ArtistElement {
  String name;
  String url;

  ArtistElement({
    required this.name,
    required this.url,
  });

  factory ArtistElement.fromRawJson(String str) =>
      ArtistElement.fromJson(json.decode(str));

  factory ArtistElement.fromJson(Map<String, dynamic> json) => ArtistElement(
        name: json["name"] ?? '',
        url: json["url"] ?? '',
      );
}
