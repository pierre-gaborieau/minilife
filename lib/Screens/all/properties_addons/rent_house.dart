import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/static_house.dart';
import 'package:minilife/Model/Houses/rent.dart';

class RentHouse extends StatelessWidget {
  const RentHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: StaticHouse.availableRent.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.house),
              title: Text(StaticHouse.availableRent[index].house.name),
              subtitle: Text("Annual wage : " +
                  StaticHouse.availableRent[index].wage.toString() +
                  " € • Monthly Wage : " +
                  (StaticHouse.availableRent[index].wage ~/ 12).toString() +
                  " €"),
              onTap: () {
                Rent temp = StaticHouse.availableRent[index];
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
                              " €"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                                Navigator.pop(context, true);
                                DataCommon.mainCharacter.rentApply(temp);
                              },
                              child: const Text('Apply for the rent'),
                            ),
                          ],
                        ));
              },
            );
          }),
    );
  }
}
