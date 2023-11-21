import 'package:flutter/material.dart';
import 'package:practica_final_3/widgets/widgets.dart';

/* Anem ara a veure la nostra classe HomeScreen. La classe HomeScreen com hem indicat a les rutes serà la 
pàgina per defecte de la nostra aplicacio. Aquesta classe és una subclasse de StatelessWidget ja que no ha de
fer canviar d'estats. Dins el 'build' retornarem un Scaffold per poder crear al pagina e indicarem una 'AppBar' 
amb el seu titol i un boto al qual li indicarm una funcio per poder obrir un cercador.

Tambe feim servir els Widgets Stack, Gesture i Container per poder fer que clicant en qualsevol lloc de la pantalla
tambe poguem obrir el mateix cercador per cercar artistes. Aplicam uns estils perque es vegi millor.*/
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music App'),
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
      body: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Pulsa para buscar',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'En qualquier lugar de la pantalla',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomSearch(context),
              );
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
