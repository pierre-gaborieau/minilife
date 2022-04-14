import 'dart:math';
import 'package:flutter/material.dart';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Data/static_carreer.dart';
import 'package:minilife/Data/static_degree.dart';
import 'package:minilife/Data/static_formations.dart';
import 'package:minilife/Data/static_house.dart';
import 'package:minilife/Data/static_music.dart';
import 'package:minilife/Model/Alcool/alcool.dart';
import 'package:minilife/Model/Carreer/carreer.dart';
import 'package:minilife/Model/Carreer/job_offer.dart';
import 'package:minilife/Model/Carreer/poste.dart';
import 'package:minilife/Model/Country/country.dart';
import 'package:minilife/Model/Health/regime.dart';
import 'package:minilife/Model/Houses/rent.dart';
import 'package:minilife/Model/Leisure/Music/instrument.dart';
import 'package:minilife/Model/Leisure/Music/instrument_object.dart';
import 'package:minilife/Model/Leisure/Music/instrument_practice.dart';
import 'package:minilife/Model/Leisure/Music/music_genre.dart';
import 'package:minilife/Model/Relations/children_relations.dart';
import 'package:minilife/Model/Relations/love_relation.dart';
import 'package:minilife/Model/Relations/parent_relation.dart';
import 'package:minilife/Model/School/degree.dart';
import 'package:minilife/Model/School/formation.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/band.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/musician.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/records.dart';
import 'package:minilife/Model/SpecialCarreer/celebrity.dart';
import 'package:minilife/Screens/screens.dart';
import 'package:minilife/Widgets/widgets.dart';

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
  late String deathReason;

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

  //Celebrity Info
  Celebrity? celebrity;
  List<Band> listBand = [];

  //Family Info
  ParentRelation? mother;
  ParentRelation? father;
  late LoveRelation love;
  List<Human> sibblings = [];
  List<ChildrenRelation> childrens = [];

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

  //Leisure Info
  int creativity = 0;
  bool practice = false;
  List<InstrumentObject> instrumentObject = [];
  List<InstrumentPractice> instrumentPractice = [];

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
    creativity = 0;
    practice = false;
    canLottery = true;
    askPayRise = true;
    bool vretour = false;
    StaticCarreer.regenerateJobOffer();
    StaticHouse.generateRent();
    StaticHouse.generateSell();
    StaticCarreer.jobOffer.shuffle();
    StaticMusic.generateSellInstrument();

    canWorkHarder = true;
    canTherapy = true;
    //gestion du bonheur
    updateHappiness(-(3 + alcoolAddict.length));
    age++;
    DataFeed.addEvent("\n\n" + age.toString() + " years old");
    everyYearRiskOfDeath(false, context, update);
    ageOther(context, update);
    if (celebrity != null) celebrity!.updateFanbase();
    if (listBand.isNotEmpty) musicianPay();

    //gestion du regime
    updateHealth(regime.health);
    updateHappiness(regime.happinness);
    if (!parentsHouse) balance -= regime.price;

    if (livingCountry != nationality) yearsOfEmigrate++;

    if (retired) {
      balance += retirementAid * 1000;
    }

    if (age > 9 && age < 18) {
      int money = nextInt(1, 300);
      DataFeed.addEvent(
          "You received " + money.toString() + "€ by your parents");
      balance += money;
    }

    if (performancePro != null && performancePro! > 0) {
      performancePro = nextInt(
          (performancePro! * 0.9).toInt(), (performancePro! * 1.1).toInt());
      updatePerformancePro(0);
    }

    for (var element in instrumentObject) {
      element.updatePopularityAndPrice();
    }

    for (var elem in instrumentPractice) {
      elem.updateMastery();
    }

    if (Random().nextInt(501) == Random().nextInt(501)) {
      StaticMusic.instrumentToSell.shuffle();
      InstrumentObject gift = StaticMusic.instrumentToSell.first;
      DataFeed.addEvent("A stranger gave you a " + gift.getName());
      updateHappiness(10);
      instrumentObject.add(gift);
      StaticMusic.generateSellInstrument();
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

    for (var element in houses) {
      element.yearlyFunction(this);
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
    creativity += nextInt(0, 10);
    if (happiness < 20 || happiness > 80) creativity += nextInt(1, 20);
    if (happiness == 0 || happiness == 100) creativity += nextInt(1, 20);
    creativity += numberOfAddiction() * nextInt(1, 4);
    if (actualJobOffer != null) creativity = creativity ~/ 2;
    if (health < 20 || health > 80) creativity += nextInt(1, 10);
    return vretour;
  }

  purchaseInstrument(InstrumentObject instrument) {
    if (balance > instrument.price) {
      updateHappiness(10);
      DataFeed.addEvent("You just bought a " + instrument.getName() + " !");
      balance -= instrument.price;
      instrumentObject.add(instrument);
      StaticMusic.instrumentToSell.remove(instrument);
    } else {
      DataFeed.addEvent("You cannot afford that.");
      updateHappiness(-5);
    }
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
    bool success = offer.rentApply(this);
    if (success) {
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
    bool success = countryChoice.emigrate(this);

    int price = nextInt(0, 2500);

    if (success) {
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
        DataCommon.generateData();
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
      if (age < 35 &&
          houses
              .where((element) => element.house.localisation == livingCountry)
              .isEmpty) {
        parentsHouse = true;
        parentsFree = true;
        DataFeed.addEvent("I went back to my parents house.");
      }
      houses.remove(house);
    } else {
      DataFeed.addEvent("Nobody was interested in your house.");
    }
  }

  musicianPay() {
    for (var element in StaticMusic.listMusicGenre) {
      element.updatePopularity();
    }
    int payout = 0;
    for (Band band in listBand) {
      band.updateFanbase();
      for (Records rec in band.disco) {
        if (rec.years == 0) {
          DataFeed.addEvent(band.bandName + " released the new record.");
        }
        payout += rec.buyUnits();
      }
    }
    if (payout > 9600) {
      yearsOfWork++;
      unemployment += 1 / 2;
    }

    balance += payout;
    DataFeed.addEvent(
        "I earned " + payout.toString() + "€ from my music releases");
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

  everyYearRiskOfDeath(
      bool other, BuildContext context, ValueChanged<int> _update) {
    int proba = 0;
    proba += age ~/ 10;

    if (health == 0) {
      proba += 20;
    } else {
      proba += ((1 / health) * 100).toInt();
    }

    proba += numberOfAddiction() * 5;

    if (Random().nextInt(1001) < proba) {
      alive = false;
      if (!other) {
        deathReason = "You died in mysterious conditions...";
        DataFeed.addEvent(deathReason);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DeathScreen(update: _update)));
      } else {
        DataFeed.addEvent(getFullName() + " died in mysterious conditions...");
        if (childrens
            .where((element) => element.parent == DataCommon.mainCharacter)
            .isNotEmpty) {
          int relation = childrens
              .where((element) => element.parent == DataCommon.mainCharacter)
              .first
              .relation;
          DataCommon.mainCharacter.updateHappiness(-(relation ~/ 2));
        }
      }
    }
  }

  void goBackToParents() {
    if (mother != null && mother!.parent.alive) {
      if (mother!.parent.regime != regime) {
        regime = mother!.parent.regime;
      }
    }
  }

  String getFullName() {
    return firstName + " " + lastName;
  }

  void ageOther(BuildContext context, ValueChanged<int> update) {
    if (mother != null && mother!.parent.alive) {
      mother!.parent.age++;
      mother!.parent.everyYearRiskOfDeath(true, context, update);
    }
    if (father != null && father!.parent.alive) {
      father!.parent.age++;
      father!.parent.everyYearRiskOfDeath(true, context, update);
    }
  }

  void changeFoodHabits(Regime regimeChoice) {
    regime = regimeChoice;
    DataFeed.addEvent("Your new food habit is : " + regime.nom);
  }

  practiceInstrument(Instrument instrument, bool lesson) {
    if (!practice) {
      practice = true;
      if (instrumentPractice
          .where((element) => element.instrument == instrument)
          .isEmpty) {
        instrumentPractice.add(InstrumentPractice(
            instrument: instrument, mastery: nextInt(0, 15), playedGenres: []));
      }
      int prog = Random().nextInt(11);
      if (lesson) {
        if (parentsFree) {
          DataFeed.addEvent(
              "You parents paid you a " + instrument.name + " lesson");
        } else {
          balance -= instrument.practicePrice;
        }
        prog += Random().nextInt(11);
      }
      instrumentPractice
          .where((element) => element.instrument == instrument)
          .first
          .mastery += prog;

      if (instrumentPractice
              .where((element) => element.instrument == instrument)
              .first
              .mastery <
          0) {
        instrumentPractice
            .where((element) => element.instrument == instrument)
            .first
            .mastery = 0;
      }
      if (instrumentPractice
              .where((element) => element.instrument == instrument)
              .first
              .mastery >
          100) {
        instrumentPractice
            .where((element) => element.instrument == instrument)
            .first
            .mastery = 100;
      }

      DataFeed.addEvent("You practiced " + instrument.name);
    } else {
      DataFeed.addEvent("You already practice an instrument this year.");
    }
  }

  void createMusicArtist(String pseudo, Instrument instrument) {
    if (instrumentPractice
        .where((element) => element.instrument == instrument)
        .isEmpty) {
      instrumentPractice.add(InstrumentPractice(
          instrument: instrument, mastery: nextInt(0, 5), playedGenres: []));
      DataFeed.addEvent("I have start playing " + instrument.name);
    }

    if (celebrity == null) {
      celebrity = Celebrity(name: pseudo, fanbase: 0);
    } else if (pseudo != celebrity!.name) {
      celebrity!.name = pseudo;
      DataFeed.addEvent("I am now known as " + pseudo);
    }

    celebrity!.listSpe
        .add(Musician(instrument: instrument, genre: [], disco: []));
  }

  void createMusicBand(String bandName, bool isSolo, Genre genre) {
    int members;
    if (isSolo) {
      members = 1;
    } else if (Random().nextBool()) {
      members = nextInt(6, 11);
    } else {
      members = nextInt(2, 6);
    }

    listBand.add(Band(
        bandName: bandName,
        members: members,
        genre: [genre],
        fanbase: 0,
        disco: []));
    DataFeed.addEvent("I am now playing in " + bandName);
  }

  sellInstrument(InstrumentObject instrument) {
    if (Random().nextBool()) {
      int price = instrument.price;
      price += instrument.popularity;
      price += instrument.inspiration;
      if (celebrity != null) {
        if (celebrity!.fanbase > 1000) {
          price += instrument.albumRecords * (celebrity!.fanbase ~/ 1000);
        } else if (celebrity!.fanbase > 100) {
          price += instrument.albumRecords * (celebrity!.fanbase ~/ 100);
        }
      }
      balance += price;
      DataFeed.addEvent("You sold your " +
          instrument.getName() +
          " for " +
          price.toString() +
          "€.");
    } else {
      DataFeed.addEvent("Nobody want your instrument");
    }
  }
}
