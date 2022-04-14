import 'dart:math';

import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Data/static_country.dart';
import 'package:minilife/Data/static_house.dart';
import 'package:minilife/Data/static_music.dart';
import 'package:minilife/Data/static_regime.dart';
import 'package:minilife/Model/Alcool/alcool.dart';
import 'package:minilife/Model/Country/country.dart';
import 'package:minilife/Model/Health/regime.dart';
import 'package:minilife/Model/Human/human.dart';
import 'package:minilife/Model/Relations/children_relations.dart';
import 'package:minilife/Model/Relations/love_relation.dart';
import 'package:minilife/Model/Relations/parent_relation.dart';

class DataCommon {
  static Future<void> generateMainCharacters() async {
    Country country = StaticCountry
        .worldList[Random().nextInt(StaticCountry.worldList.length)];
    int ageMother = nextInt(18, 40);
    int ageFather = nextInt(18, ageMother + 10);
    int balanceParent = nextInt(1000, 1000000);

    Country countryMother = StaticCountry
        .worldList[Random().nextInt(StaticCountry.worldList.length)];
    Country countryFather = StaticCountry
        .worldList[Random().nextInt(StaticCountry.worldList.length)];
    Regime regimeParents = StaticRegime
        .listRegime[Random().nextInt(StaticRegime.listRegime.length)];
    String fatherLastName =
        countryFather.lastName[Random().nextInt(countryFather.lastName.length)];
    Human mother = Human(
        countryMother.getName(false),
        countryMother.lastName[Random().nextInt(countryMother.lastName.length)],
        false,
        ageMother,
        Random().nextInt(101),
        regimeParents,
        countryMother,
        country,
        country,
        null,
        null);
    Human father = Human(
        countryFather.getName(true),
        fatherLastName,
        true,
        ageFather,
        Random().nextInt(101),
        regimeParents,
        countryFather,
        country,
        country,
        null,
        null);
    LoveRelation parents = LoveRelation(mother, father);
    if (Random().nextInt(101) > 33) {
      parents.married = true;
      parents.balance = balanceParent;
      mother.lastName = father.lastName;
    } else {
      mother.balance = balanceParent ~/ 2;
      father.balance = balanceParent ~/ 2;
    }

    mother.love = parents;
    father.love = parents;

    bool isMale = Random().nextBool();
    String firstName = country.getName(isMale);

    mainCharacter = Human(
        firstName,
        fatherLastName,
        isMale,
        0,
        Random().nextInt(101),
        regimeParents,
        country,
        country,
        country,
        ParentRelation(mother, true),
        ParentRelation(father, false));

    ChildrenRelation relation = ChildrenRelation(
        parent: mainCharacter, isAdopted: false, isStep: false);

    mother.childrens.add(relation);
    father.childrens.add(relation);

    DataFeed.addEvent("You were born as " +
        DataCommon.mainCharacter.getFullName() +
        " you are living in " +
        DataCommon.mainCharacter.livingCountry.name);
    DataFeed.addEvent(
        "Your parents food habits are : " + mainCharacter.regime.nom);
    DataFeed.addEvent("Your parents are " +
        mother.getFullName() +
        " and " +
        father.getFullName());
    if (Random().nextInt(1001) == Random().nextInt(1001)) {
      DataFeed.addEvent("Your mother died while she was giving you birth.");
      mother.alive = false;
      mainCharacter.father!.relation -= 50;
    }
    generateData();
  }

  static late Human mainCharacter;

  static void generateData() {
    StaticHouse.generateRent();
    StaticHouse.generateSell();
    StaticMusic.generateSellInstrument();
  }

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

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
