import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_house.dart';
import 'package:minilife/Model/Houses/rent.dart';

class BuyHouse extends StatelessWidget {
  const BuyHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: StaticHouse.availableToBuy.length,
            itemBuilder: (context, index) {
              return ListTile(
                  leading: const Icon(Icons.house),
                  title: Text(StaticHouse.availableToBuy[index].house.name),
                  subtitle: Text("Price : " +
                      StaticHouse.availableToBuy[index].house.value.toString() +
                      " € • Annual Wage : " +
                      StaticHouse.availableToBuy[index].wage.toString() +
                      " €"),
                  onTap: () {
                    Rent temp = StaticHouse.availableToBuy[index];
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text(temp.house.name),
                              content: Text("Bedrooms : " +
                                  temp.house.rooms.toString() +
                                  " \nBathrooms : " +
                                  temp.house.bathrooms.toString() +
                                  " \nSize of garden : " +
                                  temp.house.terrainSize.toString() +
                                  " m² \nPool : " +
                                  (temp.house.pool == true ? "Yes" : "No") +
                                  "\nAnnual Wage : " +
                                  temp.wage.toString() +
                                  " €\nPrice : " +
                                  temp.house.value.toString() +
                                  "€"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                    Navigator.pop(context, true);
                                    DataCommon.mainCharacter
                                        .buyHouse(temp, true);
                                  },
                                  child: const Text('20 years pay'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                    Navigator.pop(context, true);
                                    DataCommon.mainCharacter
                                        .buyHouse(temp, false);
                                  },
                                  child: const Text('Buy it cash !'),
                                ),
                              ],
                            ));
                  });
            }));
  }
}
