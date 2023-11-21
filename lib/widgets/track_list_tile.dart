import 'package:flutter/material.dart';
import 'package:practica_final_3/models/models.dart';

/*Classe per mostrar cada canço d'un album amb un ListTile. Aquesta classe rebra un objecte Track i el numero de Track i despres
retornam un ListTile indicant un estil, el numero de Track, el nom, l'artista i la duracio d'aquesta amb el format adequat.*/
class TrackListTile extends StatelessWidget {
  final Track track;
  final int trackNumber;

  const TrackListTile(
      {super.key, required this.track, required this.trackNumber});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 60,
        height: 40,
        child: Center(
          child: Text(
            trackNumber.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      title: Text(track.name),
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.only(right: 16),
      subtitle: Text(track.artist.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formattedDuration(Duration(seconds: track.duration)),
            style: TextStyle(fontSize: 14.5, color: Colors.blueGrey[600]),
          ),
        ],
      ),
      onTap: () => {},
    );
  }

  /*Funcio per formatar i mostrar la duracio correctament.*/
  String _formattedDuration(Duration duration) {
    String twoDigit(int number) => number >= 10 ? '$number' : '0$number';
    final minutes = twoDigit(duration.inMinutes % 60);
    final seconds = twoDigit(duration.inSeconds % 60);
    return '$minutes:$seconds';
  }
}
