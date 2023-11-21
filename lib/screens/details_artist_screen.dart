import 'package:flutter/material.dart';
import 'package:practica_final_3/models/models.dart';
import 'package:practica_final_3/providers/movies_provider.dart';
import 'package:practica_final_3/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/*La classe 'DetailsArtistScreen' sera la pagina utilitzada per mostrar tota la informacio d'un artista en concret.
Per aixo crearem dues variables finals: un objecte 'Artist' que sera passat com a argument i un 'MusicProvider'
per consultar i fer peticions a la API i rebre la informacio.

'DetailsArtistScreen' exten de StatelessWidget i dins el build retornam com tota pagina un Scaffold amb un CustomScrollView 
per poder fer scroll amb els elements continguts dins aquest. Cridam a la classe '_CustomAppBar' per poder crear una AppBar
personalitzada i '_PosterAndTitile' i '_Overview' per retornar Widgets amb la informacio de l'artista.*/
class DetailsArtistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Artist artist = ModalRoute.of(context)?.settings.arguments as Artist;
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(artist: artist),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitile(
                    artistNom: artist,
                    artistInfo: musicProvider.getArtistInfo(artist.name)),
                _Overview(artist: musicProvider.getArtistInfo(artist.name)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/*La classe _CustomAppBar es l'encarregada de crear la AppBar personalitzada. Primer li tindrem que passar un objecte Artist
i despres utilitzam un return de 'SliverAppBar' per crear la AppBar. Aplicam uns estils, i la configuram e indicam com a titol
el nom de l'artista i la foto de l'artista.*/
class _CustomAppBar extends StatelessWidget {
  final Artist artist;

  const _CustomAppBar({required this.artist});

  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll.
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
            artist.name,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(artist.image[3].text),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/*La class '_PosterAndTitile' l'utilitzarem per a retornar un Widget per mostrar informacio sobre l'artista. Primer cream
dues variables finals: un objecte Artist i un future. Aquestes variables les tindrem que passar per parametre i a continuacio
dins el build retornarem un Widget Container amb el seu estil i la imatge de l'artista. Tambe cridam a una altre funcio
(_mostrarInfoListeners) per mostrar mes informacio.*/
class _PosterAndTitile extends StatelessWidget {
  final Artist artistNom;
  final Future<ArtistInfo> artistInfo;

  const _PosterAndTitile({required this.artistNom, required this.artistInfo});

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
              image: NetworkImage(artistNom.image[3].text),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(child: _mostrarInfoListeners(textTheme))
        ],
      ),
    );
  }

  /*La funcio _mostrarInfoListeners retorna un FutureBuilder que utilitza el future de la variable global i capturam les
  dades que ens envia la API, en aquest cas un objecte ArtistInfo. Si no hi ha dades mostrarem un 'CircularProgressIndicator',
  quan hi hagi dades les mostrarem amb un estil perque es vegin millor.*/
  Widget _mostrarInfoListeners(TextTheme theme) {
    return FutureBuilder(
      future: artistInfo,
      builder: (BuildContext context, AsyncSnapshot<ArtistInfo> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final artistInfo = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artistInfo.name,
              style: const TextStyle(fontSize: 22),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Row(
              children: [
                const Icon(Icons.play_circle_outline_outlined,
                    size: 20, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                    NumberFormat.decimalPattern()
                        .format(int.parse(artistInfo.playcount)),
                    style: theme.caption),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.headphones_outlined,
                    size: 20, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                    NumberFormat.decimalPattern()
                        .format(int.parse(artistInfo.listeners)),
                    style: theme.caption),
              ],
            ),
          ],
        );
      },
    );
  }
}

/*La class '_Overview' l'utilitzarem tambe per a retornar un Widget per mostrar mes informacio sobre l'artista. Primer cream
una variabla final: un future. Aquesta variable la tindrem que passar per parametre i a continuacio
dins el build retornarem un FutureBuilder que utilitza el future de la variable global i capturam les
dades que ens envia la API, en aquest cas un objecte ArtistInfo. Si no hi ha dades mostrarem un 'CircularProgressIndicator',
quan hi hagi dades les mostrarem amb un estil perque es vegin millor. Cridam a altres funcions que retornen Widgets per mostrar
l'informacio i organitzar el codi.*/
class _Overview extends StatelessWidget {
  final Future<ArtistInfo> artist;

  const _Overview({required this.artist});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: artist,
      builder: (BuildContext context, AsyncSnapshot<ArtistInfo> snapshot) {
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

        final artistInfo = snapshot.data!;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TagsWrap(
                  tags: artistInfo.tags
                      .tags), //Passam un llista de 'Tag' i retorna un Widget.
              Text(
                artistInfo.bio.summary.replaceAll(RegExp(r'\.\s*<a.*'),
                    '.'), //Per llevar la part html '<a' final.
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 10),
              _botoNavegador(artistInfo
                  .url), //Passam la url de l'artista i retorna un Widget.
            ],
          ),
        );
      },
    );
  }

  /*Aquesta funcio retorna un Widget Container i dintre utilitzam altres Widgets i _launchUrl per poder obrir la URL de l'artista
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
