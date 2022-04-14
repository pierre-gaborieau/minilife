import 'dart:math';

import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Model/Human/human.dart';

class Country {
  final String name;
  final List<String> firstNameMale;
  final List<String> firstNameFemale;
  final List<String> lastName;
  final bool bordersOpen;

  Country(
    this.name,
    this.firstNameMale,
    this.firstNameFemale,
    this.lastName,
    this.bordersOpen,
  );

  getName(bool isMale) {
    if (isMale) {
      return firstNameMale[Random().nextInt(firstNameMale.length)];
    } else {
      return firstNameFemale[Random().nextInt(firstNameFemale.length)];
    }
  }

  bool emigrate(Human human) {
    int proba = 80;

    if (this == human.nationality) proba == 100;

    if (!bordersOpen) {
      proba -= 30;
      DataFeed.addEvent(
          name + " has closed their borders. I have to ask for a Visa");
    }

    return (Random().nextInt(101) <= proba);
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
