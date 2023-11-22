import 'package:flutter/material.dart';
import 'package:practica_final_3/models/models.dart';
import 'package:practica_final_3/providers/movies_provider.dart';
import 'package:provider/provider.dart';

/*Classe que exten de SearchDelegate per poder crear el cercador d'artistes a traves de la API. Utilitzam 'searchFieldLabel' per
indicar una label per defecte i completam les funcions requerides.*/
class CustomSearch extends SearchDelegate {
  final BuildContext _context;

  CustomSearch(this._context) : super(searchFieldLabel: 'Search an artist...');

  /*Funcio que retorna una llista de Widgets pe fer diferents accions, en aquest cas per esborrar la query.*/
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          // close(context, null);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  /*Funcio per tancar el cercador i tornar a la pagina anterior.*/
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  /*Funcio per construir els resultats quan clicam el boto de cercar.*/
  @override
  Widget buildResults(BuildContext context) {
    return _construirResultats();
  }

  /*Funcio per construir els resultats a mesura que anam escrivint.*/
  @override
  Widget buildSuggestions(BuildContext context) {
    return _construirResultats();
  }

  /*Funcio per mostrar els resultats, si la query esta buida no podrem cercar i sortira un missatge, sino a traves d'un
  MusicProvider farem la peticio a la API i capturarem el resultat, en aquest cas una llista d'objectes Artist. Mentre no hi
  hagi dades mostrarem un CircularProgressIndicator(), sino amb els elements de la llista crearem un ListView amb les diferents 
  opcions d'artistes amb el seu nom. Si clicam damunt alguna opcio anirem a la pagina de TopAlbums amb l'element Navigator.pushNamed.*/
  Widget _construirResultats() {
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a search query!'),
      );
    }

    final artistsProvider = Provider.of<MusicProvider>(_context, listen: false);
    return FutureBuilder(
      future: artistsProvider.getArtistBySearch(query),
      builder: (BuildContext context, AsyncSnapshot<List<Artist>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final matchQuery = snapshot.data!;

        if (matchQuery.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline, size: 150),
                    Text('The artist provided not found...',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'topAlbumsAndArtist',
                    arguments: matchQuery[index]);
              },
              child: ListTile(
                title: Text(matchQuery[index].name),
              ),
            );
          },
        );
      },
    );
  }
}
