import 'package:flutter/material.dart';
import 'package:minilife/Model/Alcool/alcool.dart';
import 'package:minilife/Model/Carreer/carreer.dart';
import 'package:minilife/Model/Milieu/milieu.dart';
import 'package:minilife/Model/School/degree.dart';

class DataCommon {
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
  static List<Degree> listDegree = [
    Degree("Primary School", 1),
    Degree("Secondary School", 2),
    Degree("High School", 3),
    Degree("University", 4),
    Degree("Graduate", 5),
    Degree("Special School", 6),
  ];
  static List<Carreer> listCarreer = [
    Carreer("Computer Science", milieuTechnology, [])
  ];

  static Milieu milieuTechnology =
      Milieu("Technology", const Icon(Icons.code_outlined));
}
