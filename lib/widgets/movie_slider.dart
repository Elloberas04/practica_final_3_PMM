import 'package:flutter/material.dart';
import 'package:practica_final_3/models/models.dart';

/*Classe que retorna un Widget en aquest cas un FutureBuilder. Aqui crearem un Slider tambe dels albums mes top d'un artista.
Amb el future capturarem les dades, en aquest cas una llista d'objectes Album. Si no hi ha dades mostrarem un Widget CircularProgressIndicator,
sinos crearem un llista horitzontal amb els _AlbumPoster.*/
class MovieSlider extends StatelessWidget {
  final Future<List<Album>> albumsfuture;
  final String nom;

  const MovieSlider({super.key, required this.albumsfuture, required this.nom});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: albumsfuture,
      builder: (BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final llistaAlbums = snapshot.data!;

        return SizedBox(
          width: double.infinity,
          height: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(nom,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: llistaAlbums.length,
                  itemBuilder: (_, int index) => _AlbumPoster(
                    movie: llistaAlbums[index],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

/*Classe que rep un objecte Album i retorna un Container per mostrar la seva foto, el nom de l'album. Amb el Widget GestureDetector
si clicam damunt aquestes targetes ens dirigirem a la pestanya de informacio de detall de l'album amb Navigator.pushNamed.*/
class _AlbumPoster extends StatelessWidget {
  final Album movie;

  const _AlbumPoster({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detailsAlbum', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.image[2].text),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
