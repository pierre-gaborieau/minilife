import 'package:minilife/Model/Leisure/Music/instrument.dart';
import 'package:minilife/Model/Leisure/Music/music_genre.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/records.dart';
import 'package:minilife/Model/SpecialCarreer/celebrity_spe.dart';

class Musician extends CelebritySpe {
  Instrument instrument;
  List<Genre> genre = [];
  List<Records> disco = [];

  Musician({
    required this.instrument,
    required this.genre,
    required this.disco,
  }) : super(true);
}
