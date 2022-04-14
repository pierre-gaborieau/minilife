import 'dart:math';

import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Model/Leisure/Music/music_genre.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/albumtype.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/band.dart';

class Records {
  final String name;
  final Band band;
  final int quality;
  final Genre genre;
  final AlbumType type;
  int years = 0;
  int sales = 0;
  bool isGold = false;
  bool isPlatinum = false;
  bool isMultiPlatinum = false;
  bool isDiamond = false;

  Records(this.name, this.band, this.quality, this.genre, this.type);

  int buyUnits() {
    int units = 0;
    int proba = 5;
    int experience =
        band.disco.where((element) => element.genre == genre).length;

    if (experience > 1) {
      proba += 5;
    }
    if (experience > 5) {
      proba += 10;
    }
    if (experience > 10) {
      proba += 15;
    }
    if (band.fanbase > 0) {
      if (sales < band.fanbase) {
        proba = proba + (band.fanbase ~/ 5);
        proba = proba + (DataCommon.mainCharacter.celebrity!.fanbase ~/ 10);
      }
    }

    if (band.disco.where((element) => element.years < 5).isEmpty) {
      proba = proba ~/ 4;
    }
    if (quality <= 10) proba -= 10;
    if (quality <= 20) proba -= 5;
    if (quality <= 30) proba -= 2;
    if (quality >= 50) proba += 5;
    if (quality >= 70) proba += 10;
    if (quality >= 90) proba += 20;
    if (quality >= 100) proba += 25;

    if (years == 0) (proba * 1.5).toInt();
    if (years > 5) proba ~/ 2;
    if (years > 10) proba ~/ 4;
    if (proba > 5) {
      proba = (proba * ((genre.popularity * 10) / 101)).toInt();
      units = nextInt(5, proba);
    } else {
      units = 10;
    }
    if (type.name.toLowerCase() == "demo") units / 2;
    years++;
    sales += units;
    int price = type.price;

    int vretour = units * (price ~/ years);

    if (sales >= 50000) {
      if (!isGold) {
        DataFeed.addEvent(name + " has been certified gold.");
        isGold = true;
      }
      if (sales > 100000) {
        if (!isPlatinum) {
          DataFeed.addEvent(name + " has been certified platinum.");
          isPlatinum = true;
        }
        if (sales > 200000) {
          if (!isMultiPlatinum) {
            DataFeed.addEvent(name + " has been certified multi-platinum.");
            isMultiPlatinum = true;
          }
          if (sales > 1000000) {
            if (!isDiamond) {
              DataFeed.addEvent(name + " has been certified diamond.");
              isDiamond = true;
            }
          }
        }
      }
    }

    band.fanbase += ((1 / 3) * units).toInt();
    DataCommon.mainCharacter.celebrity!.fanbase += units ~/ 4;

    if (band.disbanded) {
      vretour = ((vretour ~/ band.members) ~/ 3) ~/ 3;
    } else if (!band.isActive) {
      vretour = ((vretour ~/ band.members) ~/ 3) ~/ 2;
    } else {
      vretour = ((vretour ~/ band.members) ~/ 3);
    }

    return vretour;
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
