import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/band.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/musician.dart';
import 'package:minilife/Screens/screens.dart';
import 'package:minilife/Widgets/widgets.dart';

class MusicCarreer extends StatelessWidget {
  const MusicCarreer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        if (DataCommon.mainCharacter.age < 15)
          ListTile(
            tileColor: Colors.grey[200],
            leading: const Icon(Icons.bedroom_baby_outlined),
            title: const Text("You are to young to become a musician"),
          ),
        if (((DataCommon.mainCharacter.celebrity != null &&
                    DataCommon.mainCharacter.celebrity!.listSpe
                        .where((element) => element.runtimeType == Musician)
                        .isEmpty) ||
                DataCommon.mainCharacter.celebrity == null) &&
            DataCommon.mainCharacter.age >= 15)
          ListTile(
            leading: const Icon(Icons.star_border),
            title: const Text("Become an artist"),
            onTap: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => const NewArtistDialog()),
          ),
        if (DataCommon.mainCharacter.celebrity != null &&
            DataCommon.mainCharacter.celebrity!.listSpe
                .where((element) => element.runtimeType == Musician)
                .isNotEmpty)
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Create a new band"),
            onTap: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => const NewBandDialog()),
          ),
        for (int i = 0; i < DataCommon.mainCharacter.listBand.length; i++)
          ListTile(
            leading: const Icon(Icons.supervisor_account_sharp),
            title: Text(DataCommon.mainCharacter.listBand[i].bandName),
            subtitle: Text(
                DataCommon.mainCharacter.listBand[i].members.toString() +
                    " members" +
                    (DataCommon.mainCharacter.listBand[i].disbanded
                        ? "Disbanded"
                        : "")),
            onTap: () =>
                _navigateToBand(context, DataCommon.mainCharacter.listBand[i]),
          ),
      ]),
    );
  }

  void _navigateToBand(BuildContext context, Band band) async {
    var translate = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MusicBand(band: band)));

    if (translate == true) {
      Navigator.pop(context, true);
    }
  }
}
