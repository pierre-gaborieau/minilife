import 'dart:math';

import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Model/Houses/house.dart';
import 'package:minilife/Model/Houses/rent.dart';

class StaticHouse {
  static List<House> listHouseType = [
    House(
      name: "Tiny Appartment",
      rooms: 0,
      bathrooms: 1,
      terrainSize: 0,
      pool: false,
      value: 100000,
      minAnnualPrice: 100,
      maxAnnualPrice: 1000,
    ),
    House(
      name: "Small Appartment",
      rooms: 1,
      bathrooms: 1,
      terrainSize: 0,
      pool: false,
      value: 120000,
      minAnnualPrice: 500,
      maxAnnualPrice: 1500,
    ),
    House(
      name: "Appartment",
      rooms: 2,
      bathrooms: 1,
      terrainSize: 0,
      pool: false,
      value: 130000,
      minAnnualPrice: 1000,
      maxAnnualPrice: 2000,
    ),
    House(
      name: "Familly Appartment",
      rooms: 3,
      bathrooms: 1,
      terrainSize: 0,
      pool: false,
      value: 150000,
      minAnnualPrice: 1500,
      maxAnnualPrice: 2500,
    ),
    House(
      name: "Big Appartment",
      rooms: 4,
      bathrooms: 2,
      terrainSize: 0,
      pool: false,
      value: 200000,
      minAnnualPrice: 2500,
      maxAnnualPrice: 3500,
    ),
    House(
      name: "Huge Appartment",
      rooms: 7,
      bathrooms: 5,
      terrainSize: 0,
      pool: true,
      value: 500000,
      minAnnualPrice: 5000,
      maxAnnualPrice: 15000,
    ),
  ];

  static List<Rent> availableRent = [];
  static List<Rent> availableToBuy = [];

  static generateSell() {
    availableToBuy.clear();
    List<House> tmpHouse = [];
    tmpHouse = listHouseType;
    for (int i = 0; i < 10; i++) {
      House houseToCopy = tmpHouse[Random().nextInt(tmpHouse.length)];
      House houseToRent = House(
          name: houseToCopy.name,
          rooms: houseToCopy.rooms,
          bathrooms: houseToCopy.bathrooms,
          terrainSize: houseToCopy.terrainSize,
          pool: houseToCopy.pool,
          value: houseToCopy.value,
          minAnnualPrice: houseToCopy.minAnnualPrice,
          maxAnnualPrice: houseToCopy.maxAnnualPrice);
      houseToRent.localisation = DataCommon.mainCharacter.livingCountry;
      houseToRent.value =
          nextInt((houseToRent.value * 0.8).toInt(), houseToRent.value * 2);
      Rent temp = Rent(houseToRent, houseToRent.value ~/ 20, true);
      availableToBuy.add(temp);
    }
  }

  static generateRent() {
    availableRent.clear();
    List<House> tmpHouse = [];
    tmpHouse = listHouseType;
    for (int i = 0; i < 10; i++) {
      House houseToCopy = tmpHouse[Random().nextInt(tmpHouse.length)];
      House houseToRent = House(
          name: houseToCopy.name,
          rooms: houseToCopy.rooms,
          bathrooms: houseToCopy.bathrooms,
          terrainSize: houseToCopy.terrainSize,
          pool: houseToCopy.pool,
          value: houseToCopy.value,
          minAnnualPrice: houseToCopy.minAnnualPrice,
          maxAnnualPrice: houseToCopy.maxAnnualPrice);
      houseToRent.localisation = DataCommon.mainCharacter.livingCountry;
      houseToRent.value =
          nextInt((houseToRent.value * 0.8).toInt(), houseToRent.value * 2);
      int wageMin = (houseToRent.value ~/ 30);
      int wageMax = (houseToRent.value ~/ 10);
      Rent temp = Rent(houseToRent, nextInt(wageMin, wageMax), false);
      availableRent.add(temp);
    }
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
