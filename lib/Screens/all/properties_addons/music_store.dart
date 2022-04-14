import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_music.dart';

class MusicStore extends StatelessWidget {
  const MusicStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (int i = 0; i < StaticMusic.instrumentToSell.length; i++)
            ListTile(
              leading: const Icon(Icons.music_note_rounded),
              title: Text(StaticMusic.instrumentToSell[i].getName()),
              subtitle: Text(
                  StaticMusic.instrumentToSell[i].brand.instrument.name +
                      " - " +
                      StaticMusic.instrumentToSell[i].price.toString() +
                      " €"),
              onTap: () {
                DataCommon.mainCharacter
                    .purchaseInstrument(StaticMusic.instrumentToSell[i]);
                Navigator.pop(context, true);
              },
            )
        ],
      ),
    );
  }
}
