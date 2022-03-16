import 'dart:developer';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Data/static_degree.dart';
import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Model/School/degree.dart';
import 'package:minilife/Model/School/formation.dart';

class Human {
  String firstName;
  String lastName;
  int age;
  Formation? currentlyLearning;
  List<Formation> listFormations = [];
  bool isLearning = false;

  Human(this.firstName, this.lastName, this.age);

  ageUp() {
    age++;
    DataFeed.addEvent("\n\n" + age.toString() + " years old");

    if (age == StaticFormations.agePrimary) {
      isLearning = true;
      setCurrentlyLearning(StaticFormations.formationPrimary);
    }

    if (isLearning) {
      if (currentlyLearning!.ageGraduate == age) {
        listFormations.add(currentlyLearning!);
        Degree aimDegree = currentlyLearning!.degree;
        if (aimDegree == StaticDegree.graduate) {
          DataFeed.addEvent("I graduated from " + currentlyLearning!.nom);
          isLearning = false;
          currentlyLearning = null;
        } else if (aimDegree == StaticDegree.primary) {
          setCurrentlyLearning(StaticFormations.formationSecondary);
        } else if (aimDegree == StaticDegree.secondary) {
          ///TODO : Si athlete proposer HighSchoolSport
          setCurrentlyLearning(StaticFormations.formationHigh);
        } else if (aimDegree == StaticDegree.high) {
          ///TODO : Choix Cursus ou dropout
          setCurrentlyLearning(StaticFormations.formationComputerScience);
        } else if (aimDegree == StaticDegree.university) {
          ///TODO : Choix Graduate ou dropout
          setCurrentlyLearning(StaticFormations.formationGraduate);
        }
      }
    }
  }

  setCurrentlyLearning(Formation formation) {
    if (currentlyLearning != null) {
      DataFeed.addEvent("I graduated from " + currentlyLearning!.nom);
    }
    currentlyLearning = formation;
    currentlyLearning!.setGraduate(age);
    DataFeed.addEvent("I've start to learn at " + formation.nom);
  }

  dropOutSchool() {
    if (age >= StaticFormations.minDropOutAge) {
      isLearning = false;
      currentlyLearning = null;
      DataFeed.addEvent("I droped-out from school");
    }
  }
}
