import 'dart:math';

import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Data/static_country.dart';
import 'package:minilife/Data/static_regime.dart';
import 'package:minilife/Model/Alcool/alcool.dart';
import 'package:minilife/Model/Country/country.dart';
import 'package:minilife/Model/Human/human.dart';

class DataCommon {
  static void generateMainCharacter() {
    bool isMale = Random().nextBool();
    Country country = StaticCountry
        .worldList[Random().nextInt(StaticCountry.worldList.length + 1)];
    String firstName = country.getName(isMale);

    String lastName =
        country.lastName[Random().nextInt(country.lastName.length + 1)];
    mainCharacter = Human(
        firstName,
        lastName,
        isMale,
        0,
        Random().nextInt(101),
        StaticRegime
            .listRegime[Random().nextInt(StaticRegime.listRegime.length + 1)],
        country,
        country,
        country);

    DataFeed.addEvent("You were born as " +
        DataCommon.mainCharacter.firstName +
        " " +
        DataCommon.mainCharacter.lastName +
        " you are living in " +
        DataCommon.mainCharacter.livingCountry.name);
    DataFeed.addEvent(
        "You parents food habits are : " + mainCharacter.regime.nom);
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
