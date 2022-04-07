import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Data/static_carreer.dart';
import 'package:minilife/Data/static_degree.dart';
import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Data/static_house.dart';
import 'package:minilife/Model/Alcool/alcool.dart';
import 'package:minilife/Model/Carreer/carreer.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';
import 'package:minilife/Model/Carreer/poste.dart';
import 'package:minilife/Model/Country/country.dart';
import 'package:minilife/Model/Health/regime.dart';
import 'package:minilife/Model/Houses/rent.dart';
import 'package:minilife/Model/Relations/love_relation.dart';
import 'package:minilife/Model/Relations/parent_relation.dart';
import 'package:minilife/Model/School/degree.dart';
import 'package:minilife/Model/School/formation.dart';
import 'package:minilife/Screens/all/home_screen.dart';

class Human {
  //Base infos
  String firstName;
  String lastName;
  int age;
  int happiness = 100;
  int balance = 0;
  int health;
  bool alive = true;
  bool male;

  //Health info
  Regime regime;

  //School/Work infos
  Formation? currentlyLearning;
  List<Formation> listFormations = [];
  bool isLearning = false;
  int? performancePro;
  List<JobOffer> career = [];
  int yearsOfWork = 0;
  double unemployment = 1;
  late int retirementAid;
  bool canAugment = true;
  int yearsBeforeAugment = 0;
  late bool askPayRise;
  bool retired = false;
  JobOffer? actualJobOffer;
  bool canWorkHarder = true;

  //Family Info
  ParentRelation? mother;
  ParentRelation? father;
  late LoveRelation love;
  List<Human> sibblings = [];
  List<Human> childrens = [];

  //Addictions Info
  List<Alcool> alcoolAddict = [];
  bool canTherapy = true;
  bool canLottery = true;

  //Country Info
  Country birthCountry;
  Country nationality;
  Country livingCountry;
  late int yearsOfEmigrate;

  //Houses Info
  bool parentsHouse = true;
  bool parentsFree = true;
  List<Rent> houses = [];

  Human(
      this.firstName,
      this.lastName,
      this.male,
      this.age,
      this.health,
      this.regime,
      this.birthCountry,
      this.nationality,
      this.livingCountry,
      this.mother,
      this.father);

  bool ageUp(BuildContext context, ValueChanged<int> update) {
    canLottery = true;
    askPayRise = true;
    bool vretour = false;
    StaticCarreer.regenerateJobOffer();
    StaticHouse.generateRent();
    StaticHouse.generateSell();
    StaticCarreer.jobOffer.shuffle();

    canWorkHarder = true;
    canTherapy = true;
    //gestion du bonheur
    updateHappiness(-(3 + alcoolAddict.length));
    age++;
    DataFeed.addEvent("\n\n" + age.toString() + " years old");
    everyYearRiskOfDeath(false);
    ageOther();

    //gestion du regime
    updateHealth(regime.health);
    updateHappiness(regime.happinness);
    if (!parentsHouse) balance -= regime.price;

    if (livingCountry != nationality) yearsOfEmigrate++;

    if (retired) {
      balance += retirementAid * 1000;
    }

    if (performancePro != null && performancePro! > 0) {
      performancePro = nextInt(
          (performancePro! * 0.9).toInt(), (performancePro! * 1.1).toInt());
      updatePerformancePro(0);
    }

    ///Jour de paie !
    if (actualJobOffer != null) {
      yearsOfWork++;
      unemployment = unemployment + 1 / 3;
      actualJobOffer!.yearsInPost++;
      balance += actualJobOffer!.salaire * 1000;

      //gestion augmentation
      if (canAugment) {
        askPayrise(false);
      } else {
        yearsBeforeAugment--;
        if (yearsBeforeAugment == 0) {
          canAugment = true;
        }
      }
    } else if (!retired) {
      if (currentlyLearning == null && age > 18) {
        if (unemployment >= 1) {
          unemployment--;
          int value = 9600;
          DataFeed.addEvent(
              "I received " + value.toString() + " € of unemployment aid");
          balance += value;
        } else {
          DataFeed.addEvent("I am not eligible to receive unemployment aid");
        }
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
          element.house.value = nextInt((element.house.value * 0.9).toInt(),
              (element.house.value * 1.1).toInt());
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
        updateHappiness(-20);
        actualJobOffer = null;
        canAugment = true;
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
          }
        } else if (aimDegree == StaticDegree.university) {
          /// Choix Graduate ou dropout
          if (performancePro! > 90) {
            setCurrentlyLearning(StaticFormations.formationGraduate);
          } else {
            DataFeed.addEvent("My grades were too bad to apply to a graduate");
            isLearning = false;
            currentlyLearning = null;
          }
        }
      }
    }

    if ((yearsOfWork == 43 || age == 70) && !retired) {
      showDialog(
          context: context,
          builder: (BuildContext context) => RetirementDialog(update: update));
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

    if (!parentsHouse &&
        houses
            .where((element) => element.house.localisation == livingCountry)
            .isEmpty) updateHealth(-10);

    updateHealth(-alcoolAddict.length * 2);

    return vretour;
  }

  askCitizenship() {
    int proba = 10;
    if (actualJobOffer != null) proba += 10;
    if (houses
        .where((element) => element.house.localisation == livingCountry)
        .isNotEmpty) proba += 10;
    if (yearsOfEmigrate > 2) proba += 5;
    if (yearsOfEmigrate > 5) proba += 10;
    if (yearsOfEmigrate > 10) proba += 15;
    if (yearsOfEmigrate > 20) proba += 20;

    if (Random().nextInt(101) <= proba) {
      DataFeed.addEvent("I'm no longer a citizen of " +
          nationality.name +
          ", I am now officialy living in " +
          livingCountry.name);
      updateHappiness(10);
      nationality = livingCountry;
    } else {
      DataFeed.addEvent("My request to become Citizen has been refused");
      updateHappiness(-10);
    }
  }

  setCurrentlyLearning(Formation formation) {
    if (currentlyLearning != null) {
      DataFeed.addEvent("I graduated from " + currentlyLearning!.nom);
      updateHappiness(15);
    }
    if (performancePro != null) {
      updatePerformancePro(-Random().nextInt(11));
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
      updateHappiness(15);
    } else {
      DataFeed.addEvent("My offer for the rent was refused.");
      updateHappiness(-5);
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
        updateHappiness(10);
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
          if (offer.poste.carreer.listPoste!
              .where((element) => element.echelon == offer.poste.echelon - 1)
              .isNotEmpty) {
            Poste previousEchelon = offer.poste.carreer.listPoste!
                .where((element) => element.echelon == offer.poste.echelon - 1)
                .first;
            if (previousEchelon.requirement == null) {
              proba += 35;
            }
          }
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
        updateHappiness(20);
        if (performancePro != null) {
          if (performancePro! <= 0) performancePro = 1;
          performancePro =
              nextInt((performancePro! * 0.8).toInt(), performancePro!);
        } else {
          performancePro = 40;
        }
        actualJobOffer = offer;
        DataFeed.addEvent("I've start a new job as a " +
            offer.poste.nom +
            " at " +
            offer.entreprise.nom);
      } else {
        updateHappiness(-10);
        DataFeed.addEvent("I didn't get the job of " +
            offer.poste.nom +
            " at " +
            offer.entreprise.nom);
      }
    }
  }

  updateHappiness(int increment) {
    happiness += increment;
    happiness >= 100 ? happiness = 100 : true;

    happiness <= 0 ? happiness = 0 : true;
  }

  updatePerformancePro(int increment) {
    performancePro = performancePro! + increment;
    performancePro! >= 100 ? performancePro = 100 : true;
    performancePro! <= 0 ? performancePro = 0 : true;
  }

  updateHealth(int increment) {
    health = health + increment;
    health >= 100 ? health = 100 : true;
    health <= 0 ? health = 0 : true;
  }

  workharder() {
    if (performancePro != null) {
      canWorkHarder = false;
      int randnum = Random().nextInt(101);
      if (randnum > 50) {
        DataFeed.addEvent("I've start working harder");
        updatePerformancePro(nextInt(1, 20));
      } else {
        DataFeed.addEvent("I tried to work harder but prefered to play.");
      }
    }
  }

  void emigrate(Country countryChoice) {
    int proba = 80;
    int price = nextInt(0, 2500);

    if (countryChoice == nationality) proba == 100;

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
        updateHappiness(25);
        if (actualJobOffer != null) {
          DataFeed.addEvent(
              "I had to leave my job since I doesn't leave anymore in " +
                  livingCountry.name);
          career.add(actualJobOffer!);
          actualJobOffer = null;
          updateHappiness(-10);
        }
        parentsHouse = false;
        livingCountry = countryChoice;
        yearsOfEmigrate = 0;
        StaticHouse.generateSell();
        StaticHouse.generateRent();
      } else {
        DataFeed.addEvent("I was admit to " +
            countryChoice.name +
            " but I cannot afford the plane ticket...");
        updateHappiness(-10);
      }
    } else {
      DataFeed.addEvent(
          "I haven't been allowed to emigrate in " + countryChoice.name);
      updateHappiness(-15);
    }
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }

  void retire() {
    late int lowest;
    late int highest;
    if (actualJobOffer != null) {
      career.add(actualJobOffer!);
      actualJobOffer = null;
    }
    for (int i = 0; i < career.length; i++) {
      if (i == 0) {
        lowest = career[i].salaire;
        highest = career[i].salaire;
      } else {
        if (career[i].salaire < lowest) {
          lowest = career[i].salaire;
        } else if (career[i].salaire > highest) {
          highest = career[i].salaire;
        }
      }
    }

    retirementAid = ((lowest + highest) / 2 * 0.8).toInt();
    retired = true;
    DataFeed.addEvent("I am now retired. I will receive an annual aid of : " +
        retirementAid.toString() +
        "k €");
  }

  void resign() {
    DataFeed.addEvent("I resigned from my job");
    updatePerformancePro(-Random().nextInt(11));
    career.add(actualJobOffer!);
    actualJobOffer = null;
  }

  void askPayrise(bool isAsk) {
    if (actualJobOffer!.salaire < actualJobOffer!.poste.salaireMax) {
      if (!isAsk || (isAsk && askPayRise)) {
        askPayRise = false;
        int probaAugmentation = 10;
        if (performancePro! > 40) probaAugmentation += 5;
        if (performancePro! > 50) probaAugmentation += 5;
        if (performancePro! > 60) probaAugmentation += 10;
        if (performancePro! > 70) probaAugmentation += 10;
        if (performancePro! > 80) probaAugmentation += 10;
        if (performancePro! > 90) probaAugmentation += 5;
        if (performancePro! == 100) probaAugmentation += 5;
        if (Random().nextInt(101) <= probaAugmentation) {
          canAugment = false;
          yearsBeforeAugment = 5;
          int newSalaire = nextInt((actualJobOffer!.salaire * 1.01).toInt(),
              (actualJobOffer!.salaire * 2).toInt());
          actualJobOffer!.salaire = newSalaire;
          DataFeed.addEvent("I got a payrise. I'm now paid " +
              newSalaire.toString() +
              "k € yearly");
          updateHappiness(15);
        } else if (isAsk) {
          DataFeed.addEvent("I didn't got my payrise.");
          updateHappiness(-5);
        }
      } else {
        DataFeed.addEvent("I didn't got my payrise.");
      }
    } else {
      if (isAsk) {
        DataFeed.addEvent(
            "I was eligible for a payrise but I already have the maximum salary");
      }
    }
  }

  void askPromotion() {
    Carreer carreer = actualJobOffer!.poste.carreer;

    if (actualJobOffer!.poste.echelon < carreer.listPoste!.last.echelon) {
      Poste newPoste = carreer.listPoste!
          .where(
              (element) => element.echelon == actualJobOffer!.poste.echelon + 1)
          .first;

      int proba = 10;
      if (actualJobOffer!.yearsInPost >= 5) proba += 5;
      if (actualJobOffer!.yearsInPost >= 10) proba += 15;

      if (performancePro! < 50) proba -= 10;
      if (performancePro! > 70) proba += 20;
      if (performancePro! > 80) proba += 10;

      if (Random().nextInt(101) <= proba) {
        JobOffer newJobOffer = JobOffer(
            entreprise: actualJobOffer!.entreprise,
            poste: newPoste,
            salaire: nextInt((actualJobOffer!.salaire * 1.1).toInt(),
                (actualJobOffer!.salaire * 1.5).toInt()));

        DataFeed.addEvent("I have been promoted to " + newPoste.nom);
        career.add(actualJobOffer!);
        actualJobOffer = newJobOffer;
        updateHappiness(10);
      } else {
        DataFeed.addEvent("I didn't got my promotion");
        updateHappiness(5);
      }
    } else {
      DataFeed.addEvent("You are already at the climax of this carreer");
    }
  }

  void cancelRent(Rent house) {
    DataFeed.addEvent("I leaved my " + house.house.name + " rental.");
    houses.remove(house);
    if (age < 35 && livingCountry == birthCountry) {
      DataFeed.addEvent("I went back to my parents house");
      parentsHouse = true;
      parentsFree = true;
    }
  }

  void buyHouse(Rent temp, bool mortgage) {
    if (!mortgage && temp.house.value >= balance) {
      DataFeed.addEvent("You don't have enough money to buy this house");
      updateHappiness(-10);
    } else if (!mortgage && temp.house.value < balance) {
      DataFeed.addEvent("You just bought a " + temp.house.name);
      houses.add(temp);
      parentsHouse = false;
      balance -= temp.house.value;
      updateHappiness(15);
    } else if (mortgage && actualJobOffer == null) {
      DataFeed.addEvent("You need a job to apply for a mortgage");
      updateHappiness(-10);
    } else if (mortgage && actualJobOffer!.salaire * 1000 <= temp.wage) {
      DataFeed.addEvent("You dont earn enough money to buy this house");
      updateHappiness(-10);
    } else {
      temp.duration = 20;
      DataFeed.addEvent("You just signed a " +
          temp.duration.toString() +
          " years mortgage to buy a " +
          temp.house.name);
      houses.add(temp);
      parentsHouse = false;
      updateHappiness(10);
    }
  }

  void sellHouse(Rent house) {
    int proba = Random().nextInt(101);
    if (Random().nextInt(101) < proba) {
      DataFeed.addEvent("You managed to sell your " +
          house.house.name +
          " for " +
          house.house.value.toString() +
          ".");
      balance += house.house.value;
      if (house.duration > 0) {
        int remainingMortgage = house.wage * house.duration;
        balance -= remainingMortgage;
        DataFeed.addEvent(remainingMortgage.toString() +
            "€ were used to pay the end of the mortgage.");
      }
      if (age < 35) {
        parentsHouse = true;
        parentsFree = true;
        DataFeed.addEvent("I went back to my parents house.");
      }
      houses.remove(house);
    } else {
      DataFeed.addEvent("Nobody was interested in your house.");
    }
  }

  playLoto() {
    if (canLottery) {
      if (balance > 3) {
        canLottery = false;
        balance -= 3;

        int toFind = Random().nextInt(100000);
        int ticket = Random().nextInt(100000);
        int prize = nextInt(1000, 3000000);

        if (toFind == ticket) {
          DataFeed.addEvent(
              "I won " + prize.toString() + "€ at the lottery !!!");
          updateHappiness(45);
          balance += prize;
        } else {
          DataFeed.addEvent("What a surprise ! I didn't won the lottery");
        }
      } else {
        DataFeed.addEvent("You don't even have 3€ for a lottery ticket !!");
      }
    }
  }

  everyYearRiskOfDeath(bool other) {
    int proba = 5;
    proba += age ~/ 10;

    if (health == 0) {
      proba += 35;
    } else {
      proba += ((1 / health) * 100).toInt();
    }

    proba += numberOfAddiction() * 5;

    if (Random().nextInt(101) < proba) {
      alive = false;
      if (!other) {
        DataFeed.addEvent("You died in mysterious conditions...");
      } else {
        DataFeed.addEvent(getFullName() + " died in mysterious conditions...");
      }
    }
  }

  String getFullName() {
    return firstName + " " + lastName;
  }

  void ageOther() {
    if (mother != null && mother!.parent.alive) {
      mother!.parent.age++;
      mother!.parent.everyYearRiskOfDeath(true);
    }
    if (father != null && father!.parent.alive) {
      father!.parent.age++;
      father!.parent.everyYearRiskOfDeath(true);
    }
  }
}
