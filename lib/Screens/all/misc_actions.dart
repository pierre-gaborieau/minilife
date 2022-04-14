import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_country.dart';
import 'package:minilife/Model/Country/country.dart';
import 'package:minilife/Widgets/widgets.dart';

class MiscActions extends StatelessWidget {
  final ValueChanged<int> update;
  const MiscActions({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.local_hospital_outlined),
            title: const Text("Addiction Center"),
            onTap: () => _navigateToAddiction(context),
          ),
          if (DataCommon.mainCharacter.livingCountry !=
              DataCommon.mainCharacter.nationality)
            ListTile(
              leading: const Icon(Icons.cached_rounded),
              title: const Text("Apply for a new nationality"),
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          content: const Text(
                              "Do you really want to apply for a nationality change ?"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  DataCommon.mainCharacter.askCitizenship();
                                  Navigator.pop(context);
                                  update(2);
                                },
                                child: const Text("Apply"))
                          ],
                        ));
              },
            ),
          if (DataCommon.mainCharacter.age >= 18)
            ListTile(
                leading: const Icon(Icons.airplanemode_active_outlined),
                title: const Text("Emigrate to another country"),
                onTap: () {
                  List<Country> tmpList = [];
                  tmpList.addAll(StaticCountry.worldList);
                  tmpList.remove(DataCommon.mainCharacter.livingCountry);
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => DialogEmigrate(
                            update: update,
                            listCountry: tmpList,
                          ));
                }),
          if (DataCommon.mainCharacter.age > 3)
            ListTile(
              leading: const Icon(Icons.music_note_rounded),
              title: const Text("Practice an Instrument"),
              onTap: () => _navigateToMusic(context),
            ),
          if (DataCommon.mainCharacter.age >= 18 &&
              DataCommon.mainCharacter.canLottery)
            ListTile(
              leading: const Icon(Icons.euro_rounded),
              title: const Text("Buy a lottery ticket"),
              onTap: () {
                DataCommon.mainCharacter.playLoto();
                update(2);
              },
            ),
          if (DataCommon.mainCharacter.parentsHouse == false)
            ListTile(
              leading: const Icon(Icons.food_bank_outlined),
              title: const Text("Choose your food habits"),
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context2) =>
                        DialogFood(update: update));
              },
            ),
        ],
      ),
    );
  }

  void _navigateToMusic(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed('/musicLearn');

    if (translate == true) {
      update(2);
    }
  }

  void _navigateToAddiction(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed("/addictions");

    if (translate == true) {
      update(2);
    }
  }
}
