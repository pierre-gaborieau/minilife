import 'package:minilife/Model/Leisure/Music/music_genre.dart';

class Instrument {
  final String name;
  final int difficulty;
  final List<Genre> usualGenres;
  final int practicePrice;

  Instrument(
    this.name,
    this.difficulty,
    this.usualGenres,
    this.practicePrice,
  );
}
