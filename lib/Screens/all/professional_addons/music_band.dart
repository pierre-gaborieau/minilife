import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/musician.dart';
import 'package:minilife/Widgets/widgets.dart';

import '../../../Model/SpecialCarreer/MusicArtist/band.dart';

class MusicBand extends StatelessWidget {
  final Band band;
  const MusicBand({
    Key? key,
    required this.band,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.supervisor_account_sharp),
          title: Text(band.bandName),
          subtitle: Text(band.fanbase.toString() +
              " fans • " +
              band.members.toString() +
              " members"),
        ),
        for (int i = 0; i < band.disco.length; i++)
          ListTile(
            leading: const Icon(Icons.album),
            title: Text(band.disco[i].name +
                " (" +
                band.disco[i].genre.nom +
                " " +
                band.disco[i].type.name +
                ')'),
            subtitle: Text(band.disco[i].sales.toString() +
                " units sold • Writing quality : " +
                band.disco[i].quality.toString() +
                " • " +
                band.disco[i].years.toString() +
                " years."),
            onTap: () {},
          ),
        if (band.isActive &&
            !band.disbanded &&
            DataCommon.mainCharacter.instrumentObject
                .where((element) =>
                    element.brand.instrument ==
                    (DataCommon.mainCharacter.celebrity!.listSpe
                            .where((element) => element.runtimeType == Musician)
                            .first as Musician)
                        .instrument)
                .isNotEmpty)
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("New Release"),
            onTap: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => NewRecordDialog(band: band)),
          ),
        if (band.isActive &&
            !band.disbanded &&
            DataCommon.mainCharacter.instrumentObject
                .where((element) =>
                    element.brand.instrument ==
                    (DataCommon.mainCharacter.celebrity!.listSpe
                            .where((element) => element.runtimeType == Musician)
                            .first as Musician)
                        .instrument)
                .isEmpty)
          const ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("You need an instrument to record an album"),
          ),
        if (band.isActive && !band.disbanded)
          ListTile(
            leading: const Icon(Icons.pause),
            title: const Text("Pause the band"),
            onTap: () {
              band.isActive = false;
              DataFeed.addEvent(band.bandName + " is paused.");
            },
          ),
        if (!band.isActive && !band.disbanded)
          ListTile(
            leading: const Icon(Icons.play_arrow),
            title: const Text("Reunite the band"),
            onTap: () {
              band.isActive = true;
              DataFeed.addEvent(band.bandName + " is now active.");
            },
          ),
        if (!band.disbanded)
          ListTile(
            leading: const Icon(Icons.cancel),
            title: const Text("Disband the band"),
            onTap: () {
              band.disbanded = true;
              DataFeed.addEvent(band.bandName + " has now ended.");
            },
          ),
      ]),
    );
  }
}
