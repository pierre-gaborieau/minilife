import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Model/Country/country.dart';

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
