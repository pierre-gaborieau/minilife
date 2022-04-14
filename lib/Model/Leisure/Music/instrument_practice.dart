import 'dart:math';

import 'package:minilife/Model/Leisure/Music/instrument.dart';
import 'package:minilife/Model/Leisure/Music/music_genre.dart';

class InstrumentPractice {
  final Instrument instrument;
  int mastery;
  List<Genre> playedGenres;

  InstrumentPractice({
    required this.instrument,
    required this.mastery,
    required this.playedGenres,
  });

  updateMastery() {
    mastery -= 1;
    if (mastery < 0) mastery = 0;
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
