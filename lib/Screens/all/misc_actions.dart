import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_country.dart';
import 'package:minilife/Model/Country/country.dart';

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
        ],
      ),
    );
  }

  void _navigateToAddiction(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed("/addictions");

    if (translate == true) {
      update(2);
    }
  }
}

class DialogEmigrate extends StatefulWidget {
  final ValueChanged<int> update;
  final List<Country> listCountry;
  const DialogEmigrate({
    Key? key,
    required this.update,
    required this.listCountry,
  }) : super(key: key);

  @override
  State<DialogEmigrate> createState() => _DialogEmigrateState();
}

class _DialogEmigrateState extends State<DialogEmigrate> {
  late Country countryChoice;

  @override
  void initState() {
    super.initState();
    countryChoice = widget.listCountry.first;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Emigrate"),
      content: DropdownButton<Country>(
        value: countryChoice,
        items:
            widget.listCountry.map<DropdownMenuItem<Country>>((Country item) {
          return DropdownMenuItem<Country>(
            child: Text(item.name),
            value: item,
          );
        }).toList(),
        onChanged: (item) {
          setState(() {
            countryChoice = item!;
          });
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              DataCommon.mainCharacter.emigrate(countryChoice);
              widget.update(2);
            },
            child: const Text("Emigrate"))
      ],
    );
  }
}
