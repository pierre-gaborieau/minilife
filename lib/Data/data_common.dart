import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Model/Alcool/alcool.dart';
import 'package:minilife/Model/Human/human.dart';

class DataCommon {
  static Human mainCharacter = Human("Pierre", "Gaborieau", 0);

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
