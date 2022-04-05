import 'package:minilife/Data/static_degree.dart';
import 'package:minilife/Model/School/formation.dart';

class StaticFormations {
  static int agePrimary = 3;
  static int minDropOutAge = 16;

  static Formation formationPrimary = Formation(
    nom: "Primary School",
    degree: StaticDegree.primary,
    duration: 6,
  );
  static Formation formationSecondary = Formation(
    nom: "Secondary School",
    degree: StaticDegree.secondary,
    duration: 5,
  );
  static Formation formationHigh = Formation(
    nom: "High School",
    degree: StaticDegree.high,
    duration: 4,
  );

  static Formation formationHighSport = Formation(
    nom: "High School Sport Cursus",
    degree: StaticDegree.high,
    duration: 4,
  );
  static Formation formationComputerScience = Formation(
    nom: "Computer Science University",
    degree: StaticDegree.university,
    duration: 4,
  );
  static Formation formationEconomy = Formation(
      nom: "Economy University", degree: StaticDegree.university, duration: 4);

  static Formation formationGraduate = Formation(
    nom: "University Graduate",
    degree: StaticDegree.graduate,
    duration: 1,
  );

  static List<Formation> listUniveristy = [
    formationComputerScience,
    formationEconomy
  ];
}
