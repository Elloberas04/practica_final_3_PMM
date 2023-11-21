import 'package:practica_final_3/models/models.dart';

class ImageAlbum {
  String text;
  String size;

  ImageAlbum({
    required this.text,
    required this.size,
  });

  factory ImageAlbum.fromRawJson(String str) =>
      ImageAlbum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageAlbum.fromJson(Map<String, dynamic> json) => ImageAlbum(
        text: (json["#text"] == '')
            ? 'https://media.istockphoto.com/id/1193046540/es/vector/foto-pr%C3%B3ximamente-icono-de-imagen-ilustraci%C3%B3n-vectorial-aislado-sobre-fondo-blanco-no-hay.jpg?s=612x612&w=0&k=20&c=sblCjtqWoLEpWnqGZMr5yuiltE2bsiuH-WwsecNGSIA='
            : json["#text"],
        size: json["size"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "#text": text,
        "size": size,
      };
}
