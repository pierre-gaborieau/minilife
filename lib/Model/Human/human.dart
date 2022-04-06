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
    StaticCarreer.jobOffer.shuffle();

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

      //gestion augmentation
      int probaAugmentation = 10;
      if (performancePro! > 40) probaAugmentation += 5;
      if (performancePro! > 50) probaAugmentation += 5;
      if (performancePro! > 60) probaAugmentation += 10;
      if (performancePro! > 70) probaAugmentation += 10;
      if (performancePro! > 80) probaAugmentation += 10;
      if (performancePro! > 90) probaAugmentation += 5;
      if (performancePro! == 100) probaAugmentation += 5;
      if (Random().nextInt(101) <= probaAugmentation) {
        int newSalaire = nextInt((actualJobOffer!.salaire * 1.01).toInt(),
            (actualJobOffer!.salaire * 2).toInt());
        actualJobOffer!.salaire = newSalaire;
        DataFeed.addEvent("I got a payrise. I'm now paid " +
            newSalaire.toString() +
            " € yearly");
      }
    }

    ///Paie du loyer aux parents
    if (parentsFree == false && parentsHouse == true) {
      balance -= 3000;
    }

    //Paie des loyers et prets
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

    //Début du loyer à ses parents
    if (currentlyLearning == null && age >= 18 && parentsFree) {
      parentsFree = false;
      DataFeed.addEvent(
          "Your parents asked you to pay a small rent as you are not learning anymore");
    }

    //Expulsion des parents
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
                barrierDismissible: false,
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
    if (randnum <= prob) {
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

  validateSchoolRequirement(Formation formation) {
    int proba = 20;
    if (performancePro! > 20) {
      proba += 10;
    }
    if (performancePro! > 40) {
      proba += 10;
    }
    if (performancePro! > 60) {
      proba += 20;
    }
    if (performancePro! > 80) {
      proba += 20;
    }
    if (performancePro! == 100) {
      proba == 100;
    }
    int randNum = Random().nextInt(101);
    if (randNum <= proba) {
      DataFeed.addEvent("I validate the " + formation.nom);
      listFormations.add(formation);
    } else {
      DataFeed.addEvent("I failed to validate the " + formation.nom);
    }
  }

  jobInterview(JobOffer offer) {
    if (offer.alreadyAsk) {
      DataFeed.addEvent(
          offer.entreprise.nom + " asked me to stop calling them for the job");
    } else {
      //Impossible de postuler deux fois à la meme offre
      offer.alreadyAsk = true;
      int proba = 10;

      //Gestion des prérequis scolaires
      if (offer.poste.requirement != null) {
        if (listFormations.contains(offer.poste.requirement!)) {
          proba += 35;
        }
      } else {
        proba += 35;
      }

      //Si postuler au meme poste
      if (offer.poste.previousPoste != null && actualJobOffer != null) {
        if (actualJobOffer!.poste == offer.poste.previousPoste) {
          proba += 35;
          if (performancePro! > 40) {
            proba += 10;
          }
          if (performancePro! > 80) {
            proba += 25;
          }
        }
      }

      bool previous = false;
      bool same = false;
      bool upper = false;
      for (var element in career) {
        //Si le poste requis à déjà été occupé
        if (!previous && (element.poste == offer.poste.previousPoste)) {
          previous = true;
          proba += 10;
        }
        //Si le dernier poste est le même
        if (!same && (element.poste == offer.poste)) {
          same = true;
          proba += 20;
        }

        //poste supérieur déjà occupé
        if (!upper && (element.entreprise.milieu == offer.entreprise.milieu)) {
          if (element.poste.echelon > offer.poste.echelon) {
            upper = true;
            proba += 20;
          }
        }
      }

      int randNum = Random().nextInt(101);
      if (randNum <= proba) {
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

  void emigrate(Country countryChoice) {
    int proba = 80;
    int price = nextInt(0, 2500);

    if (!countryChoice.bordersOpen) {
      proba -= 30;
      DataFeed.addEvent(countryChoice.name +
          " has closed their borders. I have to ask for a Visa");
    }

    if (Random().nextInt(101) <= proba) {
      if (balance > price) {
        balance -= price;
        DataFeed.addEvent("I was admit to " +
            countryChoice.name +
            ", the trip cost me " +
            price.toString() +
            " €");
        updateHappiness(25, true);
        if (actualJobOffer != null) {
          DataFeed.addEvent(
              "I had to leave my job since I doesn't leave anymore in " +
                  livingCountry.name);
          career.add(actualJobOffer!);
          actualJobOffer = null;
          updateHappiness(10, false);
        }
        parentsHouse = false;
        livingCountry = countryChoice;
        StaticHouse.generateRent();
      } else {
        DataFeed.addEvent("I was admit to " +
            countryChoice.name +
            " but I cannot afford the plane ticket...");
        updateHappiness(10, false);
      }
    } else {
      DataFeed.addEvent(
          "I haven't been allowed to emigrate in " + countryChoice.name);
      updateHappiness(15, false);
    }
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
