import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';

class HousesScreen extends StatelessWidget {
  const HousesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            if (DataCommon.mainCharacter.parentsFree &&
                DataCommon.mainCharacter.parentsHouse)
              ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(Icons.bedroom_baby_outlined),
                title: const Text(
                    "You are currently living at your parents house"),
              ),
            if (DataCommon.mainCharacter.parentsFree == false &&
                DataCommon.mainCharacter.parentsHouse)
              ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(Icons.bedroom_baby_outlined),
                title: const Text(
                    "You are paying a 3k€ annual wage to your parents"),
              ),
            if (DataCommon.mainCharacter.parentsHouse == false &&
                DataCommon.mainCharacter.houses.isEmpty)
              ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(Icons.highlight_remove_sharp),
                title: const Text("You are currently homeless"),
              ),
            if (DataCommon.mainCharacter.age >= 18)
              ListTile(
                  tileColor: Colors.grey[200],
                  leading: const Icon(Icons.house_outlined),
                  title: const Text("Find a house to rent"),
                  onTap: () => _navigateToRent(
                        context,
                      )),
            if (DataCommon.mainCharacter.age >= 18)
              ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(Icons.house_outlined),
                title: const Text("Find a house to buy"),
              ),
            for (int i = 0; i < DataCommon.mainCharacter.houses.length; i++)
              ListTile(
                leading: const Icon(Icons.house_outlined),
                title: Text(DataCommon.mainCharacter.houses[i].house.name +
                    " • " +
                    DataCommon
                        .mainCharacter.houses[i].house.localisation!.name),
                subtitle: Text((DataCommon.mainCharacter.houses[i].isBuying
                    ? "Owner"
                    : "Rent")),
              ),
          ],
        ));
  }

  void _navigateToRent(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed('/rent');

    if (translate == true) {
      Navigator.pop(context, true);
    }
  }
}
