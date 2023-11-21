import 'package:practica_final_3/models/models.dart';

/*Per mapejar la resposta quan demanam a la API l'informacio d'un album en concret.*/
class AlbumInfoResponse {
  AlbumInfo album;

  AlbumInfoResponse({
    required this.album,
  });

  factory AlbumInfoResponse.fromRawJson(String str) =>
      AlbumInfoResponse.fromJson(json.decode(utf8.decode(str.codeUnits)));

  String toRawJson() => json.encode(toJson());

  factory AlbumInfoResponse.fromJson(Map<String, dynamic> json) =>
      AlbumInfoResponse(
        album: (json["album"] == null)
            ? AlbumInfo.empty()
            : AlbumInfo.fromJson(json["album"]),
      );

  Map<String, dynamic> toJson() => {
        "album": album.toJson(),
      };
}

class AlbumInfo {
  String artist;
  String mbid;
  String playcount;
  Tracks tracks;
  Tags tags;
  String url;
  String name;
  String listeners;
  Wiki wiki;

  AlbumInfo({
    required this.artist,
    required this.mbid,
    required this.playcount,
    required this.tracks,
    required this.tags,
    required this.url,
    required this.name,
    required this.listeners,
    required this.wiki,
  });

  factory AlbumInfo.fromRawJson(String str) =>
      AlbumInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AlbumInfo.fromJson(Map<String, dynamic> json) => AlbumInfo(
        artist: json["artist"] ?? '',
        mbid: json["mbid"] ?? '',
        playcount: json["playcount"] ?? '0',
        tracks: (json['tracks'] == null)
            ? Tracks.empty()
            : Tracks.fromJson(json["tracks"]),
        tags: (json["tags"] == "") ? Tags.empty() : Tags.fromJson(json["tags"]),
        url: json["url"] ?? '',
        name: json["name"] ?? '',
        listeners: json["listeners"] ?? '0',
        wiki:
            (json['wiki'] == null) ? Wiki.empty() : Wiki.fromJson(json['wiki']),
      );

  Map<String, dynamic> toJson() => {
        "artist": artist,
        "mbid": mbid,
        "playcount": playcount,
        "tracks": tracks.toJson(),
        "url": url,
        "name": name,
        "listeners": listeners,
        "wiki": wiki.toJson(),
      };

  factory AlbumInfo.empty() {
    return AlbumInfo(
        artist: '',
        mbid: '',
        playcount: '',
        tracks: Tracks.empty(),
        tags: Tags.empty(),
        url: '',
        name: '',
        listeners: '',
        wiki: Wiki.empty());
  }
}

class Tracks {
  List<Track> track;

  Tracks({
    required this.track,
  });

  factory Tracks.fromRawJson(String str) => Tracks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tracks.fromJson(Map<String, dynamic> json) {
    final trackJson = json["track"];
    if (trackJson is List) {
      return Tracks(
        track: List<Track>.from(json["track"].map((x) => Track.fromJson(x))),
      );
    } else {
      return Tracks(track: [Track.fromJson(trackJson)]);
    }
  }
  Map<String, dynamic> toJson() => {
        "track": List<dynamic>.from(track.map((x) => x.toJson())),
      };

  factory Tracks.empty() {
    return Tracks(track: []);
  }
}

class Track {
  int duration;
  String url;
  String name;
  ArtistTrack artist;

  Track({
    required this.duration,
    required this.url,
    required this.name,
    required this.artist,
  });

  factory Track.fromRawJson(String str) => Track.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        duration: json["duration"] ?? 0,
        url: json["url"] ?? '',
        name: json["name"] ?? '',
        artist: ArtistTrack.fromJson(json["artist"]),
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "url": url,
        "name": name,
        "artist": artist.toJson(),
      };

  factory Track.empty(String nom) {
    return Track(duration: 0, url: '', name: nom, artist: ArtistTrack.empty());
  }
}

class ArtistTrack {
  String url;
  String name;
  String mbid;

  ArtistTrack({
    required this.url,
    required this.name,
    required this.mbid,
  });

  factory ArtistTrack.fromRawJson(String str) =>
      ArtistTrack.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArtistTrack.fromJson(Map<String, dynamic> json) => ArtistTrack(
        url: json["url"] ?? '',
        name: json["name"] ?? '',
        mbid: json["mbid"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
        "mbid": mbid,
      };

  factory ArtistTrack.empty() {
    return ArtistTrack(url: '', name: '', mbid: '');
  }
}

class Wiki {
  String published;
  String summary;
  String content;

  Wiki({
    required this.published,
    required this.summary,
    required this.content,
  });

  factory Wiki.fromRawJson(String str) => Wiki.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Wiki.fromJson(Map<String, dynamic> json) => Wiki(
        published: json["published"] ?? '',
        summary: json["summary"] ?? '',
        content: json["content"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "published": published,
        "summary": summary,
        "content": content,
      };

  factory Wiki.empty() {
    return Wiki(
      published: '',
      summary: 'No wiki summary available!!',
      content: '',
    );
  }
}
