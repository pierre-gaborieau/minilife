import 'dart:math';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Data/static_carreer.dart';
import 'package:minilife/Data/static_degree.dart';
import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Model/Alcool/alcool.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';
import 'package:minilife/Model/School/degree.dart';
import 'package:minilife/Model/School/formation.dart';

class Human {
  String firstName;
  String lastName;
  int age;
  Formation? currentlyLearning;
  List<Formation> listFormations = [];
  List<Alcool> alcoolAddict = [];
  bool isLearning = false;
  int happiness = 100;
  int balance = 0;
  JobOffer? actualJobOffer;
  List<JobOffer> career = [];

  bool canTherapy = true;

  Human(this.firstName, this.lastName, this.age);

  ageUp() {
    StaticCarreer.regenerateJobOffer();

    canTherapy = true;
    //gestion du bonheur
    updateHappiness(3 + alcoolAddict.length, false);
    age++;
    DataFeed.addEvent("\n\n" + age.toString() + " years old");

    ///Jour de paie !
    if (actualJobOffer != null) {
      balance += actualJobOffer!.salaire * 1000;
    }

    ///Risque de licenciement
    if (actualJobOffer != null) {
      int risk = 5;
      if (actualJobOffer!.entreprise.hasFullCorporate == false) {
        risk += 5;
      }
      int randNum = Random().nextInt(101);
      if (randNum < risk) {
        career.add(actualJobOffer!);
        DataFeed.addEvent(
            "I have been laid off " + actualJobOffer!.entreprise.nom);
        updateHappiness(20, false);
        actualJobOffer = null;
      }
    }

    ///Début de l'école
    if (age == StaticFormations.agePrimary) {
      isLearning = true;
      setCurrentlyLearning(StaticFormations.formationPrimary);
    }

    ///Gestion de l'école
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
          /// Si athlete proposer HighSchoolSport
          setCurrentlyLearning(StaticFormations.formationHigh);
        } else if (aimDegree == StaticDegree.high) {
          /// Choix Cursus ou dropout
          setCurrentlyLearning(StaticFormations.formationComputerScience);
        } else if (aimDegree == StaticDegree.university) {
          /// Choix Graduate ou dropout
          setCurrentlyLearning(StaticFormations.formationGraduate);
        }
      }
    }

    ///Gestion addiction alcool
    if (age > 13 && DataCommon.listAlcool.length > alcoolAddict.length) {
      //Pourcentage de chance de tomber alcoolique
      double prob = 5;
      // +1% par alcooll déjà addict
      prob += alcoolAddict.length;

      if (happiness <= 50 && happiness >= 10) {
        prob += 100 / happiness;
      }
      if (happiness < 10) {
        prob += 10;
      }
      int proba = prob.toInt();
      int randnum = Random().nextInt(100);
      if (randnum < proba) {
        List<Alcool> temp = DataCommon.listAlcool
            .where((element) => !alcoolAddict.contains(element))
            .toList();
        Alcool toAdd = temp[Random().nextInt(temp.length)];
        DataFeed.addEvent("You start drinking " + toAdd.name);
        alcoolAddict.add(toAdd);
      }
    }
  }

  setCurrentlyLearning(Formation formation) {
    if (currentlyLearning != null) {
      DataFeed.addEvent("I graduated from " + currentlyLearning!.nom);
      updateHappiness(15, true);
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

  int numberOfAddiction() {
    int addiction = 0;
    addiction += alcoolAddict.length;
    return addiction;
  }

  alcoolTherapy(Alcool alcool) {
    if (canTherapy) {
      int proba = 33;
      if (happiness > 70) {
        proba += 30;
      }
      int randnum = Random().nextInt(101);
      if (randnum <= proba) {
        alcoolAddict.remove(alcool);
        DataFeed.addEvent("I managed to stop " + alcool.name);
        updateHappiness(10, true);
      } else {
        DataFeed.addEvent("I failed to stop " + alcool.name);
      }
      canTherapy = false;
    } else {
      DataFeed.addEvent("I already fought my addictions this year");
    }
  }

  jobInterview(JobOffer offer) {
    if (offer.alreadyAsk) {
      DataFeed.addEvent(
          offer.entreprise.nom + " asked me to stop calling them for the job");
    } else {
      offer.alreadyAsk = true;
      int proba = 10;
      if (offer.poste.requirement != null) {
        if (listFormations.contains(offer.poste.requirement!)) {
          proba += 35;
        }
      }
      if (offer.poste.previousPoste != null) {
        if (actualJobOffer!.poste == offer.poste.previousPoste) {
          proba += 35;
        }
      }

      int randNum = Random().nextInt(101);
      if (randNum < proba) {
        updateHappiness(20, true);
        actualJobOffer = offer;
        DataFeed.addEvent("I've start a new job as a " +
            offer.poste.nom +
            " at " +
            offer.entreprise.nom);
      } else {
        updateHappiness(10, false);
        DataFeed.addEvent("I didn't get the job of " +
            offer.poste.nom +
            " at " +
            offer.entreprise.nom);
      }
    }
  }

  updateHappiness(int increment, bool isPlus) {
    if (isPlus) {
      happiness += increment;
      happiness > 100 ? happiness = 100 : true;
    } else {
      happiness -= increment;
      happiness < 0 ? happiness = 0 : true;
    }
  }
}
