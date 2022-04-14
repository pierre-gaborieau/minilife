import 'dart:math';
import 'package:minilife/Data/data_common.dart';
import 'package:minilife/Data/data_feed.dart';
import 'package:minilife/Model/Leisure/Music/instrument_object.dart';
import 'package:minilife/Model/Leisure/Music/music_genre.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/albumtype.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/musician.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/records.dart';

class Band {
  final String bandName;
  bool isActive = true;
  bool disbanded = false;
  final int members;
  List<Genre> genre = [];
  int fanbase = 0;
  List<Records> disco = [];

  Band({
    required this.bandName,
    required this.members,
    required this.genre,
    required this.fanbase,
    required this.disco,
  });

  newAlbum(AlbumType type, Genre genreAlbum, String name,
      InstrumentObject instrument) {
    if (DataCommon.mainCharacter.creativity >= type.creativity) {
      if (instrument.inspiration > 0) {
        instrument.albumRecords++;
        if (instrument.albumRecords == 5) instrument.inspiration += 15;
        if (instrument.albumRecords == 10) instrument.inspiration += 10;
        if (instrument.albumRecords == 15) instrument.inspiration += 5;

        DataCommon.mainCharacter.creativity -= type.creativity;
        int proba = 5;

        if (instrument.inspiration > 10) {
          instrument.inspiration -= 10;
          proba += 10;
        } else {
          proba += instrument.inspiration;
          instrument.inspiration = 0;
        }
        if (genre.contains(genreAlbum)) {
          proba += 15;
        } else {
          genre.add(genreAlbum);
          proba += 5;
        }
        Musician mainchara = DataCommon.mainCharacter.celebrity!.listSpe
            .where((element) => element.runtimeType == Musician)
            .first as Musician;
        int talent = DataCommon.mainCharacter.instrumentPractice
            .where((element) => element.instrument == mainchara.instrument)
            .first
            .mastery;
        DataCommon.mainCharacter
            .practiceInstrument(mainchara.instrument, false);
        if (talent > 50) {
          proba += nextInt(35, talent);
        } else {
          if (talent <= 0) talent = 10;
          proba += nextInt(0, talent);
        }

        int max = proba + (members * 2);
        int min = proba - (members * 2);
        log(max);
        if (min < 0) min = 0;
        proba = nextInt(min, max);

        Records newRelease = Records(name, this, proba, genreAlbum, type);
        disco.add(newRelease);
        mainchara.disco.add(newRelease);
        DataFeed.addEvent("Your band " +
            bandName +
            " juste wrote a new record called " +
            name);
        DataCommon.mainCharacter.balance -= type.recordPrice;
      } else {
        DataFeed.addEvent("You don't feel inspired by your instrument..");
      }
    } else {
      DataFeed.addEvent("You are not inspired to work on this release...");
    }
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }

  updateFanbase() {
    int min = (fanbase * 0.7).toInt();
    int max = fanbase;
    if (min < 0) min = 0;
    if (max <= 0) max = 1;

    fanbase = nextInt(min, max);

    if (disbanded) {
    } else if (isActive) {
      DataCommon.mainCharacter.balance -= fanbase ~/ 50;
    } else {
      DataCommon.mainCharacter.balance -= fanbase ~/ 100;
    }
  }
}
