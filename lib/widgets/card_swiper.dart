import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:practica_final_3/models/models.dart';

/*Classe per mostrar un CardSwiper amb els albums mes top de un artista determinat. Utilitzam un FutureBuilder per fer la peticio
a la API i capturar les dades que ens retorna, en aquest cas una llista d'objectes Album. Si no hi ha dades es mostrara el Widget
CircularProgressIndicator, sino amb el Widget Swiper crearem les diferents targetes amb les imatges dels albums. Si clicam sobre
aquests ens dirigirem a la pagina d'informacio sobre l'album a traves de Navigator.pushNamed.*/
class CardSwiper extends StatelessWidget {
  final Future<List<Album>> albumsfuture;

  const CardSwiper({super.key, required this.albumsfuture});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: albumsfuture,
      builder: (BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            width: double.infinity,
            height: size.height * 0.5,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final llistaAlbums = snapshot.data!;

        return Container(
          width: double.infinity,
          // Aquest multiplicador estableix el tant per cent de pantalla ocupada 45%
          height: size.height * 0.45,
          child: Swiper(
            itemCount: llistaAlbums.length,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            itemBuilder: (BuildContext context, int index) {
              final album = llistaAlbums[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detailsAlbum',
                    arguments: album),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(album.image[2].text),
                      fit: BoxFit.cover),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
