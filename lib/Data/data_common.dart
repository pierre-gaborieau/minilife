import 'dart:math';

import 'package:minilife/Data/static_country.dart';
import 'package:minilife/Model/Alcool/alcool.dart';
import 'package:minilife/Model/Country/country.dart';
import 'package:minilife/Model/Human/human.dart';

class DataCommon {
  static void generateMainCharacter() {
    Country country = StaticCountry
        .worldList[Random().nextInt(StaticCountry.worldList.length + 1)];
    String firstName =
        country.firstName[Random().nextInt(country.firstName.length + 1)];
    String lastName =
        country.lastName[Random().nextInt(country.lastName.length + 1)];
    mainCharacter = Human(firstName, lastName, 0, country, country, country);
  }

  static late Human mainCharacter;

  static List<Alcool> listAlcool = [
    Alcool(name: "Beer", danger: 1),
    Alcool(name: "Wine", danger: 3),
    Alcool(name: "Whiskey", danger: 7),
    Alcool(name: "Rum", danger: 8),
    Alcool(name: "Vodka", danger: 8),
    Alcool(name: "Pastis", danger: 6),
    Alcool(name: "Absinthe", danger: 10),
    Alcool(name: "Cocktails", danger: 5),
    Alcool(name: "Gin", danger: 8),
  ];
}
