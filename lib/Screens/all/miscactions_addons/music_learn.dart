import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_music.dart';
import 'package:minilife/Model/Leisure/Music/instrument.dart';

class MusicLearn extends StatelessWidget {
  const MusicLearn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          for (int i = 0; i < StaticMusic.listInstrument.length; i++)
            ListTile(
              leading: const Icon(Icons.music_note_rounded),
              title: Text("Practice " + StaticMusic.listInstrument[i].name),
              subtitle: Text(DataCommon.mainCharacter.instrumentPractice
                      .where((element) =>
                          element.instrument == StaticMusic.listInstrument[i])
                      .isNotEmpty
                  ? DataCommon.mainCharacter.instrumentPractice
                          .where((element) =>
                              element.instrument ==
                              StaticMusic.listInstrument[i])
                          .first
                          .mastery
                          .toString() +
                      " %"
                  : ""),
              onTap: () {
                Instrument instrument = StaticMusic.listInstrument[i];
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context2) => AlertDialog(
                          title: Text("Practice " + instrument.name),
                          content: Text("Course price : " +
                              instrument.practicePrice.toString() +
                              "€" +
                              (DataCommon.mainCharacter.instrumentObject
                                      .where((element) =>
                                          element.brand.instrument ==
                                          instrument)
                                      .isEmpty
                                  ? "\nYou need a " +
                                      instrument.name +
                                      " to practice alone"
                                  : "")),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context2),
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  DataCommon.mainCharacter
                                      .practiceInstrument(instrument, true);
                                  Navigator.pop(context2);
                                  Navigator.pop(context, true);
                                },
                                child: const Text("Take a lesson")),
                            if (DataCommon.mainCharacter.instrumentObject
                                .where((element) =>
                                    element.brand.instrument == instrument)
                                .isNotEmpty)
                              TextButton(
                                  onPressed: () {
                                    DataCommon.mainCharacter
                                        .practiceInstrument(instrument, false);
                                    Navigator.pop(context2);
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text("Practice alone"))
                          ],
                        ));
              },
            )
        ],
      ),
    );
  }
}
