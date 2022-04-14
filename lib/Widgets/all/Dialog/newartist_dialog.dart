import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_music.dart';
import 'package:minilife/Model/Leisure/Music/instrument.dart';

class NewArtistDialog extends StatefulWidget {
  const NewArtistDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<NewArtistDialog> createState() => _NewArtistDialogState();
}

class _NewArtistDialogState extends State<NewArtistDialog> {
  String pseudo = DataCommon.mainCharacter.celebrity != null
      ? DataCommon.mainCharacter.celebrity!.getPseudo()
      : DataCommon.mainCharacter.getFullName();
  Instrument instrument = StaticMusic.listInstrument.first;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Becoming an artist.."),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: pseudo,
            onChanged: (foo) {
              setState(() {
                pseudo = foo;
              });
            },
          ),
          DropdownButton<Instrument>(
              value: instrument,
              items: StaticMusic.listInstrument
                  .map<DropdownMenuItem<Instrument>>((Instrument item) {
                return DropdownMenuItem(
                  child: Text(item.name),
                  value: item,
                );
              }).toList(),
              onChanged: (foo) {
                setState(() {
                  instrument = foo!;
                });
              })
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              DataCommon.mainCharacter.createMusicArtist(pseudo, instrument);
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: const Text("Create")),
      ],
    );
  }
}
