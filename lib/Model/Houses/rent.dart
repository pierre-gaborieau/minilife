import 'dart:math';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Model/Houses/house.dart';
import 'package:minilife/Model/Human/human.dart';

class Rent {
  final House house;
  final int wage;
  final bool isBuying;
  int duration = 0;
  int renovationAmount = 0;

  Rent(this.house, this.wage, this.isBuying);

  yearlyFunction(Human owner) {
    if (isBuying) {
      selfDestruct(owner);
      renovationAmount += nextInt(house.minAnnualPrice, house.maxAnnualPrice);
      house.value =
          nextInt((house.value * 0.9).toInt(), (house.value * 1.1).toInt());
      if (duration > 0) {
        duration--;
        owner.balance -= wage;
      }
    } else {
      owner.balance -= wage;
    }
  }

  bool rentApply(Human human) {
    int prob = 10;
    if (human.actualJobOffer != null) {
      prob += 50;
      if (human.actualJobOffer!.salaire >= wage * 2) {
        prob += 20;
      }
    }
    if (human.balance > wage) {
      prob += 10;
    }
    if (human.age < 25) {
      prob -= 15;
    }
    int randnum = Random().nextInt(101);
    bool vretour = (randnum <= prob);
    return vretour;
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }

  void selfDestruct(Human human) {
    int proba = 0;
    if (renovationAmount >= house.value ~/ 2) {
      proba += 25;
    }
    if (renovationAmount >= house.value) {
      proba += 50;
    }
    if (Random().nextInt(1001) <= proba * 10) {
      DataFeed.addEvent(
          "Your house just self-destruct due to lack of renovation");
      human.updateHappiness(-20);
      human.houses.remove(this);
    }
  }
}
