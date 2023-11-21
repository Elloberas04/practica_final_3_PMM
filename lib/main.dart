import 'package:flutter/material.dart';
import 'package:practica_final_3/providers/movies_provider.dart';
import 'package:practica_final_3/screens/screens.dart';
import 'package:provider/provider.dart';

/* Per començar amb el programa, es a dir amb l'aplicacio i poder executar-la el primer 
que tindrem que fer es crear o declarar el main. En el main ja cridam al metode runApp
el qual ens permetra començar amb la nostre aplicacio a patir d'un widget. Per aquesta 
rao cridam a la classe MyApp que exten d'un StatelessWidget.*/
void main() => runApp(AppState());

/*Per aquesta aplicacio necessitam fer peticions a una API per tant tindrem que fer us de providers, 
es el motiu d'aquesta classe intermitga entre el 'runApp' i el MyApp on utilitzam un MultiProvider
i dintre una llista d'aquests providers. Els cream amb 'ChangeNotifierProvider' i cridam a la classe.
Finalment dintre de 'child' cridam al nostre MyApp.*/
class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MusicProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

/*Dins la classe 'MyApp' sera on tindrem que posar el MaterialApp per poder crear la aplicacio. 
Farem un return per tant de un MaterialApp e indicarem una serie de caracteristiques sobre
la nostra apliacio.

En primer lloc llevarem el Banner que ens ve per defecte, indicarem un titol a la nostra app 
(aquest no es el titol que es mostra per pantalla) e indicarem les rutes i/o fitxer els quals utilitzarem. 
En aquest cas hem creat un Map<String, Widget Function(BuildContext)> el qual ens servira per anar navegant 
per les diferetns pestanyes indicant el nom establert.*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Musica App',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'detailsAlbum': (BuildContext context) => DetailsAlbumScreen(),
        'detailsArtist': (BuildContext context) => DetailsArtistScreen(),
        'topAlbumsAndArtist': (BuildContext conetxt) => TopAlbumScreen()
      },
      theme: ThemeData.light().copyWith(
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 33, 167, 194))),
    );
  }
}
