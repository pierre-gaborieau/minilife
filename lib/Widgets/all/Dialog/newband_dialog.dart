import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_music.dart';
import 'package:minilife/Model/Leisure/Music/music_genre.dart';

class NewBandDialog extends StatefulWidget {
  const NewBandDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<NewBandDialog> createState() => _NewBandDialogState();
}

class _NewBandDialogState extends State<NewBandDialog> {
  bool isSoloBand = false;
  String name = DataCommon.mainCharacter.celebrity!.getPseudo() + " band";
  Genre musicGenre = StaticMusic.listMusicGenre.first;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New band creation"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: name,
            onChanged: (foo) {
              setState(() {
                name = foo;
              });
            },
          ),
          DropdownButton<Genre>(
              value: musicGenre,
              items: StaticMusic.listMusicGenre
                  .map<DropdownMenuItem<Genre>>((Genre elem) {
                return DropdownMenuItem(
                  child: Text(elem.nom),
                  value: elem,
                );
              }).toList(),
              onChanged: (foo) {
                setState(() {
                  musicGenre = foo!;
                });
              }),
          Row(
            children: [
              Checkbox(
                  value: isSoloBand,
                  onChanged: (foo) {
                    setState(() {
                      isSoloBand = foo!;
                    });
                  }),
              const Text("Create a one man band ?")
            ],
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              DataCommon.mainCharacter
                  .createMusicBand(name, isSoloBand, musicGenre);
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: const Text("Create"))
      ],
    );
  }
}
