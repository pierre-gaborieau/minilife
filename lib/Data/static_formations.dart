import 'package:minilife/Data/static_degree.dart';
import 'package:minilife/Model/School/formation.dart';

class StaticFormations {
  static Formation formationPrimary = Formation(
      nom: "Primary School", degree: StaticDegree.primary, duration: 9);
  static Formation formationSecondary = Formation(
      nom: "Secondary School", degree: StaticDegree.secondary, duration: 5);
  static Formation formationHigh =
      Formation(nom: "High School", degree: StaticDegree.high, duration: 4);
  static Formation formationHighSport = Formation(
      nom: "High School Sport Cursus", degree: StaticDegree.high, duration: 4);
  static Formation formationComputerScience = Formation(
      nom: "Computer Science University",
      degree: StaticDegree.university,
      duration: 4);
}
