import 'dart:math';

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
}
