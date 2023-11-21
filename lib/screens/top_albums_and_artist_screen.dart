import 'package:flutter/material.dart';
import 'package:practica_final_3/models/models.dart';
import 'package:practica_final_3/providers/movies_provider.dart';
import 'package:practica_final_3/widgets/widgets.dart';
import 'package:provider/provider.dart';

/*La classe TopAlbumScreen sera la encarregada de mostrar els albums més top d'un determinat artista. Per fer aixo primer 
cream dues variables finals: un objecte Artist i un Music Provider per consultar dades a la API i capturar el resultat.
Aquesta screen s'obrira quan cliquem sobre alguna opcio dins el cercador de artistes. Per tant retornam un Scaffold, 
indicam una AppBar amb un titol i el nom de l'artista, tambe posam el boto per tornar a cercar un altre artista. Dins el
body tenim un Widget SingleChildScrollView per poder fer scroll entre els elements que conte i cridam a atres funcions 
(que retornen un Widget) per mostrar diferents informacions.*/
class TopAlbumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Artist artist = ModalRoute.of(context)?.settings.arguments as Artist;
    final musicProvider = Provider.of<MusicProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Musica (${artist.name})'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(context),
              );
            },
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              CardSwiper(albumsfuture: musicProvider.getTopAlbums(artist.name)),
              _botoArtista(context, artist),
              const SizedBox(height: 20),
              MovieSlider(
                  nom: 'Top Albums',
                  albumsfuture: musicProvider.getTopAlbums(artist.name)),
            ],
          ),
        ),
      ),
    );
  }

  /*Aquesta funcio retorna un Widget Container i dintre utilitzam altres Widgets com TextButtom i l'element Navigator.pushNamed 
  per poder canviar a la pagina 'detailsArtist' passant com a argument un objecte Artist. Aplicam un estil.*/
  Widget _botoArtista(BuildContext context, Artist artist) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, 'detailsArtist',
                arguments: artist),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline_rounded),
                SizedBox(width: 10),
                Text("Mostrar información del artista"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
