import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Data/static_carreer.dart';
import 'package:minilife/Data/static_degree.dart';
import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Data/static_house.dart';
import 'package:minilife/Model/Alcool/alcool.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';
import 'package:minilife/Model/Country/country.dart';
import 'package:minilife/Model/Houses/rent.dart';
import 'package:minilife/Model/School/degree.dart';
import 'package:minilife/Model/School/formation.dart';
import 'package:minilife/Screens/all/home_screen.dart';

class Human {
  String firstName;
  String lastName;
  int age;
  Formation? currentlyLearning;
  List<Formation> listFormations = [];
  List<Alcool> alcoolAddict = [];
  List<Rent> houses = [];
  bool isLearning = false;
  int happiness = 100;
  int balance = 0;
  JobOffer? actualJobOffer;
  int? performancePro;
  List<JobOffer> career = [];

  Country birthCountry;
  Country nationality;
  Country livingCountry;

  bool parentsHouse = true;
  bool parentsFree = true;
  bool canTherapy = true;
  bool canWorkHarder = true;

  Human(this.firstName, this.lastName, this.age, this.birthCountry,
      this.nationality, this.livingCountry);

  bool ageUp(BuildContext context, ValueChanged<int> update) {
    bool vretour = false;
    StaticCarreer.regenerateJobOffer();
    StaticHouse.generateRent();

    canWorkHarder = true;
    canTherapy = true;
    //gestion du bonheur
    updateHappiness(3 + alcoolAddict.length, false);
    age++;
    DataFeed.addEvent("\n\n" + age.toString() + " years old");

    ///Jour de paie !
    if (actualJobOffer != null) {
      actualJobOffer!.yearsInPost++;
      balance += actualJobOffer!.salaire * 1000;
    }

    if (parentsFree == false) {
      balance -= 3000;
    }

    if (houses.isNotEmpty) {
      for (var element in houses) {
        if (element.isBuying) {
          if (element.duration > 0) {
            element.duration--;
            balance -= element.wage;
          }
        } else {
          balance -= element.wage;
        }
      }
    }

    if (currentlyLearning == null && age >= 18 && parentsFree) {
      parentsFree = false;
      DataFeed.addEvent(
          "Your parents asked you to pay a small rent as you are not learning anymore");
    }

    if (parentsHouse && age == 35) {
      parentsFree = false;
      parentsHouse = false;
      DataFeed.addEvent("Your parents asked you to leave the house.");
    }

    ///Risque de licenciement
    if (actualJobOffer != null) {
      int risk = 5;
      if (actualJobOffer!.entreprise.hasFullCorporate == false) {
        risk += 5;
      }

      if (performancePro == 0) {
        risk += 20;
      } else if (performancePro! < 10) {
        risk += 15;
      } else if (performancePro! < 20) {
        risk += 10;
      } else if (performancePro! < 30) {
        risk += 5;
      }

      int randNum = Random().nextInt(101);
      if (randNum < risk) {
        career.add(actualJobOffer!);
        DataFeed.addEvent(
            "I have been laid off " + actualJobOffer!.entreprise.nom);
        updateHappiness(20, false);
        performancePro = null;
        actualJobOffer = null;
      }
    }

    ///Début de l'école
    if (age == StaticFormations.agePrimary) {
      isLearning = true;
      setCurrentlyLearning(StaticFormations.formationPrimary);
      performancePro = Random().nextInt(101);
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
          if (performancePro! > 60) {
            // ignore: unused_local_variable
            Formation universityChoice = StaticFormations.listUniveristy[0];
            showDialog(
                context: context,
                builder: (BuildContext context) => UniversityDialog(
                      update: update,
                    ));
            vretour = true;
          } else {
            DataFeed.addEvent("My grades were too bad to apply to university");
            isLearning = false;
            currentlyLearning = null;
            performancePro = null;
          }
        } else if (aimDegree == StaticDegree.university) {
          /// Choix Graduate ou dropout
          if (performancePro! > 90) {
            setCurrentlyLearning(StaticFormations.formationGraduate);
          } else {
            DataFeed.addEvent("My grades were too bad to apply to a graduate");
            isLearning = false;
            currentlyLearning = null;
            performancePro = null;
          }
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

    return vretour;
  }

  setCurrentlyLearning(Formation formation) {
    if (currentlyLearning != null) {
      DataFeed.addEvent("I graduated from " + currentlyLearning!.nom);
      updateHappiness(15, true);
    }
    if (performancePro != null) {
      updatePerformancePro(10, false);
    } else {
      performancePro = 40;
    }
    currentlyLearning = formation;
    currentlyLearning!.setGraduate(age);
    DataFeed.addEvent("I've start to learn at " + formation.nom);
  }

  dropOutSchool() {
    if (age >= StaticFormations.minDropOutAge) {
      isLearning = false;
      currentlyLearning = null;
      performancePro = null;
      DataFeed.addEvent("I droped-out from school");
    }
  }

  rentApply(Rent offer) {
    int prob = 10;
    if (actualJobOffer != null) {
      prob += 50;
      if (actualJobOffer!.salaire >= offer.wage * 2) {
        prob += 20;
      }
    }

    if (balance > offer.wage) {
      prob += 10;
    }

    if (age < 25) {
      prob -= 15;
    }
    int randnum = Random().nextInt(101);
    if (randnum < prob) {
      parentsHouse = false;
      parentsFree = false;
      houses.add(offer);
      DataFeed.addEvent("I'm now renting a new " +
          offer.house.name +
          " in " +
          offer.house.localisation!.name +
          ".");
      updateHappiness(15, true);
    } else {
      DataFeed.addEvent("My offer for the rent was refused.");
      updateHappiness(5, false);
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
      if (offer.poste.previousPoste != null && actualJobOffer != null) {
        if (actualJobOffer!.poste == offer.poste.previousPoste) {
          proba += 35;
        }
      }

      for (var element in career) {
        if (element.poste == offer.poste.previousPoste) {
          proba += 10;
        }
        if (element.poste == offer.poste) {
          proba += 20;
        }
      }

      int randNum = Random().nextInt(101);
      if (randNum < proba) {
        if (actualJobOffer != null) {
          career.add(actualJobOffer!);
        }
        updateHappiness(20, true);
        performancePro = 40;
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

  updatePerformancePro(int increment, bool isPlus) {
    if (isPlus) {
      performancePro = performancePro! + increment;
      performancePro! > 100 ? performancePro = 100 : true;
    } else {
      performancePro = performancePro! - increment;
      performancePro! < 0 ? performancePro = 0 : true;
    }
  }

  workharder() {
    if (performancePro != null) {
      canWorkHarder = false;
      int randnum = Random().nextInt(101);
      if (randnum > 50) {
        DataFeed.addEvent("I've start working harder");
        updatePerformancePro(10, true);
      } else {
        DataFeed.addEvent("I tried to work harder but prefered to play.");
      }
    }
  }
}
