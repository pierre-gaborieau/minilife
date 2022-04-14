import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';

class MiscScreen extends StatelessWidget {
  const MiscScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (int i = 0;
              i < DataCommon.mainCharacter.instrumentObject.length;
              i++)
            ListTile(
              leading: const Icon(Icons.music_note_rounded),
              title:
                  Text(DataCommon.mainCharacter.instrumentObject[i].getName()),
              onTap: () => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context2) => AlertDialog(
                        title: Text(DataCommon.mainCharacter.instrumentObject[i]
                            .getName()),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (DataCommon.mainCharacter.listBand.isNotEmpty)
                              Text("Album Recorded : " +
                                  DataCommon.mainCharacter.instrumentObject[i]
                                      .albumRecords
                                      .toString()),
                            Text("Price : " +
                                DataCommon
                                    .mainCharacter.instrumentObject[i].price
                                    .toString() +
                                "€"),
                            Text("Inspiration : " +
                                DataCommon.mainCharacter.instrumentObject[i]
                                    .inspiration
                                    .toString()),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context2),
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                DataCommon.mainCharacter.sellInstrument(
                                    DataCommon
                                        .mainCharacter.instrumentObject[i]);
                                Navigator.pop(context2);
                                Navigator.pop(context, true);
                              },
                              child: const Text("Sell"))
                        ],
                      )),
            ),
        ],
      ),
    );
  }
}
