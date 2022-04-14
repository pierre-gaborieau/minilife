import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_regime.dart';
import 'package:minilife/Model/Health/regime.dart';

class DialogFood extends StatefulWidget {
  final ValueChanged<int> update;
  const DialogFood({Key? key, required this.update}) : super(key: key);

  @override
  State<DialogFood> createState() => _DialogFoodState();
}

class _DialogFoodState extends State<DialogFood> {
  late Regime regimeChoice;
  @override
  void initState() {
    super.initState();
    regimeChoice = DataCommon.mainCharacter.regime;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Food Habits"),
      content: DropdownButton<Regime>(
        value: regimeChoice,
        items: StaticRegime.listRegime
            .map<DropdownMenuItem<Regime>>((Regime regime) {
          return DropdownMenuItem<Regime>(
            child:
                Text(regime.nom + " - " + regime.price.toString() + "€/year"),
            value: regime,
          );
        }).toList(),
        onChanged: (item) {
          setState(() {
            regimeChoice = item!;
          });
        },
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              DataCommon.mainCharacter.changeFoodHabits(regimeChoice);
              Navigator.pop(context);
              widget.update(2);
            },
            child: const Text("Choose Regime")),
      ],
    );
  }
}
