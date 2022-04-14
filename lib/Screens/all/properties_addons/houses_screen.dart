import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Model/Houses/rent.dart';

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
                    DataCommon.mainCharacter.houses.isEmpty ||
                (DataCommon.mainCharacter.houses
                        .where((element) =>
                            element.house.localisation ==
                            DataCommon.mainCharacter.livingCountry)
                        .isEmpty &&
                    !DataCommon.mainCharacter.parentsHouse))
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
                onTap: () => _navigateToBuy(context),
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
                onTap: () {
                  Rent house = DataCommon.mainCharacter.houses[i];
                  if (house.isBuying) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context2) => AlertDialog(
                              title: Text(house.house.name),
                              content: Text(
                                "Bedrooms : " +
                                    house.house.rooms.toString() +
                                    " \nBathrooms : " +
                                    house.house.bathrooms.toString() +
                                    " \nSize of garden : " +
                                    house.house.terrainSize.toString() +
                                    " m² \nPool : " +
                                    (house.house.pool == true ? "Yes" : "No") +
                                    (house.duration > 0
                                        ? "\nAnnual Wage : " +
                                            house.wage.toString() +
                                            " €" +
                                            "\nRemaining years : " +
                                            house.duration.toString()
                                        : "") +
                                    "\nValue : " +
                                    house.house.value.toString() +
                                    "€",
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context2),
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      DataCommon.mainCharacter.sellHouse(house);
                                      Navigator.pop(context2);
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text("Sell the house"))
                              ],
                            ));
                  } else {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context2) => AlertDialog(
                              title: Text(house.house.name),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Bedrooms : " +
                                      house.house.rooms.toString()),
                                  Text("Bathrooms : " +
                                      house.house.bathrooms.toString()),
                                  Text(" \nSize of garden : " +
                                      house.house.terrainSize.toString() +
                                      " m² "),
                                  Text("Pool : " +
                                      (house.house.pool == true
                                          ? "Yes"
                                          : "No")),
                                  Text("Annual Wage : " +
                                      house.wage.toString() +
                                      " €"),
                                  Text("Amount of renovations : " +
                                      house.renovationAmount.toString() +
                                      "€")
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context2),
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      DataCommon.mainCharacter
                                          .cancelRent(house);
                                      Navigator.pop(context2);
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text("Cancel the rent"))
                              ],
                            ));
                  }
                },
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

  void _navigateToBuy(BuildContext context) async {
    var translate = await Navigator.of(context).pushNamed('/buyHouse');

    if (translate == true) {
      Navigator.pop(context, true);
    }
  }
}
