import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_final_3/models/models.dart';

class MusicProvider extends ChangeNotifier {
  final String _baseURL = 'ws.audioscrobbler.com';
  final String _apiKey = 'bcb35f22c5f8d974af6261b938d1075b';
  final String _format = 'json';
  final String _lang = 'es';

  MusicProvider() {
    print("Movies Provider inicialitzat!");
  }

  Future<List<Album>> getTopAlbums(String artist) async {
    print('getTopAlbums');
    var url = Uri.https(
      _baseURL,
      '2.0/',
      {
        'api_key': _apiKey,
        'method': 'artist.gettopalbums',
        'artist': artist,
        'format': _format
      },
    );

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final topAlbumsByArtist =
        TopAlbumsByArtistResponse.fromRawJson(result.body);

    return topAlbumsByArtist.topalbums.album;
  }

  Future<AlbumInfo> getAlbumInfo(String artist, String album) async {
    print('Demanam info al servidor [Albums]');
    print(artist);
    print(album);
    var url = Uri.http(
      _baseURL,
      '2.0/',
      {
        'api_key': _apiKey,
        'method': 'album.getinfo',
        'artist': artist,
        'album': album,
        'format': _format,
        'lang': _lang
      },
    );

    print(url);

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final albumResponse = AlbumInfoResponse.fromRawJson(result.body);

    return albumResponse.album;
  }

  Future<List<Artist>> getArtistBySearch(String artist) async {
    print('Cercam artistes al servidor');
    print(artist);
    var url = Uri.http(
      _baseURL,
      '2.0/',
      {
        'api_key': _apiKey,
        'method': 'artist.search',
        'artist': artist,
        'format': _format,
      },
    );

    print(url);

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final artists = GetArtistsBySearchResponse.fromRawJson(result.body);

    return artists.artists;
  }

  Future<ArtistInfo> getArtistInfo(String artist) async {
    print('Demanam info al servidor [Artist]');
    print(artist);
    var url = Uri.http(
      _baseURL,
      '2.0/',
      {
        'api_key': _apiKey,
        'method': 'artist.getinfo',
        'artist': artist,
        'lang': _lang,
        'format': _format,
      },
    );

    print(url);

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final artists = ArtistInfoResponse.fromRawJson(result.body);

    return artists.artist;
  }
}
