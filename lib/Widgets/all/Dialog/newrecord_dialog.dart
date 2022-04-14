import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_music.dart';
import 'package:minilife/Model/Leisure/Music/instrument_object.dart';
import 'package:minilife/Model/Leisure/Music/music_genre.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/albumtype.dart';

import 'package:minilife/Model/SpecialCarreer/MusicArtist/band.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/musician.dart';

class NewRecordDialog extends StatefulWidget {
  final Band band;
  const NewRecordDialog({
    Key? key,
    required this.band,
  }) : super(key: key);

  @override
  State<NewRecordDialog> createState() => _NewRecordDialogState();
}

class _NewRecordDialogState extends State<NewRecordDialog> {
  String name = "New Album";
  late Genre albumGenre;
  AlbumType type = StaticMusic.listAlbumType.first;
  InstrumentObject instrument = DataCommon.mainCharacter.instrumentObject
      .where((element) =>
          element.brand.instrument ==
          (DataCommon.mainCharacter.celebrity!.listSpe
                  .where((element) => element.runtimeType == Musician)
                  .first as Musician)
              .instrument)
      .where((element) => element.inspiration > 0)
      .first;

  @override
  void initState() {
    albumGenre = widget.band.genre.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New Record"),
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
              value: albumGenre,
              items: StaticMusic.listMusicGenre
                  .map<DropdownMenuItem<Genre>>((Genre genre) {
                return DropdownMenuItem(
                  child: Text(genre.nom),
                  value: genre,
                );
              }).toList(),
              onChanged: (foo) {
                setState(() {
                  albumGenre = foo!;
                });
              }),
          DropdownButton<AlbumType>(
              value: type,
              items: StaticMusic.listAlbumType
                  .map<DropdownMenuItem<AlbumType>>((AlbumType type) {
                return DropdownMenuItem(
                  child: Text(
                      type.name + " • " + type.recordPrice.toString() + "€"),
                  value: type,
                );
              }).toList(),
              onChanged: (foo) {
                setState(() {
                  type = foo!;
                });
              }),
          DropdownButton<InstrumentObject>(
              value: instrument,
              items: DataCommon.mainCharacter.instrumentObject
                  .where((element) =>
                      element.brand.instrument ==
                      (DataCommon.mainCharacter.celebrity!.listSpe
                              .where(
                                  (element) => element.runtimeType == Musician)
                              .first as Musician)
                          .instrument)
                  .where((element) => element.inspiration > 0)
                  .map<DropdownMenuItem<InstrumentObject>>((elem) {
                return DropdownMenuItem(
                    value: elem,
                    child: Text(elem.getName() +
                        " (Inspiration :" +
                        elem.inspiration.toString() +
                        ")"));
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
              widget.band.newAlbum(type, albumGenre, name, instrument);
              Navigator.pop(context);
              Navigator.pop(context, true);
            },
            child: const Text("Write")),
      ],
    );
  }
}
