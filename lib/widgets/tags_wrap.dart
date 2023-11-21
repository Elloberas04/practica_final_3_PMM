import 'package:flutter/material.dart';
import 'package:practica_final_3/models/models.dart';

/*Aquesta classe rebra una llista d'objectes Tag i retornera un Widget per poder mostrar els tag de cada artista o album. Si 
no hi ha cap element retorna un 'SizedBox.shrink()'.*/
class TagsWrap extends StatelessWidget {
  final List<Tag> tags;

  const TagsWrap({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        children: tags.map((tag) => _TagButton(tag: tag)).toList(),
      ),
    );
  }
}

/*Aquesta classe rep com a parametre un objecte Tag i el transforma a un Widget de tipus ActionChip e indica el nom del tag.
Tambe aplicam un estil.*/
class _TagButton extends StatelessWidget {
  final Tag tag;

  const _TagButton({required this.tag});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: () => {},
      label: Text(tag.name),
      labelPadding: const EdgeInsets.fromLTRB(12, 1, 12, 2),
      backgroundColor: const Color(0xFFDEE4E7),
      labelStyle: TextStyle(fontSize: 13, color: Colors.blueGrey[700]),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
