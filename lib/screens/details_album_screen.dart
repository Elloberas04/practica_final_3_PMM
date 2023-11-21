import 'package:flutter/material.dart';
import 'package:practica_final_3/models/models.dart';
import 'package:practica_final_3/providers/movies_provider.dart';
import 'package:practica_final_3/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/*La classe 'DetailsAlbumScreen' sera la pagina utilitzada per mostrar tota la informacio d'un album en concret.
Per aixo crearem dues variables finals: un objecte 'Album' que sera passat com a argument i un 'MusicProvider'
per consultar i fer peticions a la API i rebre la informacio.

'DetailsAlbumScreen' exten de StatelessWidget i dins el build retornam com tota pagina un Scaffold amb un CustomScrollView 
per poder fer scroll amb els elements continguts dins aquest. Cridam a la classe '_CustomAppBar' per poder crear una AppBar
personalitzada i '_PosterAndTitile' i '_Overview' per retornar Widgets amb la informacio de l'album.*/
class DetailsAlbumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Canviar després per una instància de Album
    final Album album = ModalRoute.of(context)?.settings.arguments as Album;
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(album: album),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(album: album),
                _Overview(
                    album: musicProvider.getAlbumInfo(
                        album.artist.name, album.name)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*La classe _CustomAppBar es l'encarregada de crear la AppBar personalitzada. Primer li tindrem que passar un objecte Album
i despres utilitzam un return de 'SliverAppBar' per crear la AppBar. Aplicam uns estils, i la configuram e indicam com a titol
el nom de l'album i la foto d'aquest.*/
class _CustomAppBar extends StatelessWidget {
  final Album album;

  const _CustomAppBar({required this.album});

  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            album.name,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(album.image[3].text),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/*La class '_PosterAndTitile' l'utilitzarem per a retornar un Widget per mostrar informacio sobre l'album. Primer cream
una variabla final: un objecte Album. Aquesta variable la tindrem que passar per parametre i a continuacio
dins el build retornarem un Widget Container amb el seu estil i la imatge de l'album. Tambe mostram de nou el nom
de l'album, el nom de l'artista i els listeners.*/
class _PosterAndTitile extends StatelessWidget {
  final Album album;

  const _PosterAndTitile({required this.album});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(album.image[3].text),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.name,
                  style: const TextStyle(fontSize: 22),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  album.artist.name,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.play_circle_outline_outlined,
                        size: 20, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(NumberFormat.decimalPattern().format(album.playcount),
                        style: textTheme.caption),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*La classe '_Overview' l'utilitzarem tambe per a retornar un Widget per mostrar mes informacio sobre l'album. Primer cream
una variabla final: un future. Aquesta variable la tindrem que passar per parametre i a continuacio
dins el build retornarem un FutureBuilder que utilitza el future de la variable global i capturam les
dades que ens envia la API, en aquest cas un objecte AlbumInfo. Si no hi ha dades mostrarem un 'CircularProgressIndicator',
quan hi hagi dades les mostrarem amb un estil perque es vegin millor. Cridam a altres funcions que retornen Widgets per mostrar
l'informacio i organitzar el codi.*/
class _Overview extends StatelessWidget {
  final Future<AlbumInfo> album;

  const _Overview({required this.album});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: album,
      builder: (BuildContext context, AsyncSnapshot<AlbumInfo> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                CircularProgressIndicator(),
              ],
            ),
          );
        }

        final albumInfo = snapshot.data!;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TagsWrap(
                  tags: albumInfo.tags
                      .tags), //Passam un llista de 'Tag' i retorna un Widget.
              Text(
                albumInfo.wiki.summary.replaceAll(RegExp(r'\.\s*<a.*'),
                    '.'), //Per llevar la part html '<a' final.
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 20),
              _botoNavegador(albumInfo
                  .url), //Passam la url de l'album i retorna un Widget.
              const SizedBox(height: 20),
              const Text(
                '-  -  -  -  -  -  Tracks  -  -  -  -  -  -',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              for (int index = 0;
                  index < albumInfo.tracks.track.length;
                  index++) //Per cada element dins la llista de Tracks cream un TrackListTile per mostrar les cancions de l'album.
                TrackListTile(
                  track: albumInfo.tracks.track[index],
                  trackNumber: index + 1,
                ),
            ],
          ),
        );
      },
    );
  }

  /*Aquesta funcio retorna un Widget Container i dintre utilitzam altres Widgets i _launchUrl per poder obrir la URL de l'album
  a un navegador, a una pagina web. Cream la URL amb 'Uri.parse(...)' i afegim un texte i un estil.*/
  Widget _botoNavegador(String url) {
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
            onPressed: () => _launchUrl(Uri.parse(url)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search),
                SizedBox(width: 10),
                Text("Abrir en el navegador"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*Aquesta funcio llança la URL per poder obrir l'enllaç a un navegador. HEM D'AFEGIR 'url_launcher' A LES DEPENDENCIES!*/
  Future<void> _launchUrl(Uri url) async {
    try {
      if (!await launchUrl(url)) {
        throw 'No es pot llançar la url: $url';
      }
    } catch (e) {
      print(e);
    }
  }
}
