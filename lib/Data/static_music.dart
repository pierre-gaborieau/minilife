import 'dart:math';

import 'package:minilife/Model/Leisure/Music/instrument.dart';
import 'package:minilife/Model/Leisure/Music/instrument_brand.dart';
import 'package:minilife/Model/Leisure/Music/instrument_object.dart';
import 'package:minilife/Model/Leisure/Music/music_genre.dart';
import 'package:minilife/Model/SpecialCarreer/MusicArtist/albumtype.dart';

class StaticMusic {
  static List<Genre> listMusicGenre = [
    Genre(nom: "Metal", popularity: Random().nextInt(101)),
    Genre(nom: "Hip-Hop", popularity: Random().nextInt(101)),
    Genre(nom: "Jazz", popularity: Random().nextInt(101)),
    Genre(nom: "Punkrock", popularity: Random().nextInt(101)),
  ];

  static List<AlbumType> listAlbumType = [
    AlbumType("Demo", 0, 15, 100),
    AlbumType("Single", 2, 5, 1000),
    AlbumType("EP", 7, 10, 3500),
    AlbumType("Album", 11, 15, 5000),
    AlbumType("Concept-Album", 18, 30, 10000),
    AlbumType("Live", 10, 10, 6000),
    AlbumType("Acoustic", 11, 15, 6000),
  ];

  static List<Instrument> listInstrument = [
    Instrument("Guitare", 2,
        [listMusicGenre[0], listMusicGenre[2], listMusicGenre[3]], 500),
    Instrument(
        "Bass Guitar",
        1,
        [
          listMusicGenre[0],
          listMusicGenre[1],
          listMusicGenre[2],
          listMusicGenre[3],
        ],
        350),
  ];

  static List<InstrumentModels> bassModels = [
    InstrumentModels(
        nom: "Crot Standart Bass",
        popularity: 70,
        minPrice: 300,
        maxPrice: 1000,
        instrument: listInstrument[1]),
    InstrumentModels(
        nom: "Rockenback 1004",
        popularity: 1000,
        minPrice: 1500,
        maxPrice: 2000,
        instrument: listInstrument[1])
  ];

  static List<InstrumentObject> signatureBass = [
    InstrumentObject(
        inspiration: nextInt(80, 150),
        brand: bassModels[1],
        price: 3800,
        popularity: 100,
        signaturePseudo: "Lommy Killer")
  ];

  static List<InstrumentModels> guitarModels = [
    InstrumentModels(
        nom: "Fandre Strat",
        popularity: 70,
        minPrice: 1000,
        maxPrice: 1500,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Fandre Strat Pro",
        popularity: 70,
        minPrice: 2000,
        maxPrice: 3000,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Fandre Television Mex",
        popularity: 70,
        minPrice: 700,
        maxPrice: 900,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Fandre Strat Mex",
        popularity: 70,
        minPrice: 700,
        maxPrice: 1000,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Ibez MetalPlayer 6",
        popularity: 70,
        minPrice: 300,
        maxPrice: 3000,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Ibez MetalPlayer 7",
        popularity: 70,
        minPrice: 500,
        maxPrice: 3000,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Ibez MetalPlayer 8",
        popularity: 70,
        minPrice: 800,
        maxPrice: 3000,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Gob LP",
        popularity: 80,
        minPrice: 900,
        maxPrice: 9000,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "WoodPlank Strat",
        popularity: 10,
        minPrice: 80,
        maxPrice: 200,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "WoodPlank LP",
        popularity: 10,
        minPrice: 80,
        maxPrice: 200,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Gob LP PoopbutGob",
        popularity: 60,
        minPrice: 900,
        maxPrice: 1000,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Fandre Jazzplayer Mex",
        popularity: 60,
        minPrice: 700,
        maxPrice: 1000,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Soular 7s",
        popularity: 60,
        minPrice: 700,
        maxPrice: 1200,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Soular 6s",
        popularity: 60,
        minPrice: 600,
        maxPrice: 1100,
        instrument: listInstrument[0]),
    InstrumentModels(
        nom: "Soular 8s",
        popularity: 60,
        minPrice: 800,
        maxPrice: 1300,
        instrument: listInstrument[0]),
  ];

  static List<InstrumentObject> guitarSignatures = [
    InstrumentObject(
        inspiration: nextInt(80, 150),
        brand: guitarModels[2],
        price: 1950,
        popularity: 80,
        signaturePseudo: "John Doe"),
    InstrumentObject(
        inspiration: nextInt(150, 200),
        brand: guitarModels[0],
        price: 7500,
        popularity: 100,
        signaturePseudo: "Instlife Tribute"),
    InstrumentObject(
        brand: guitarModels[14],
        price: 1700,
        popularity: 70,
        inspiration: nextInt(80, 150),
        signaturePseudo: "Ola England")
  ];

  static List<InstrumentObject> instrumentToSell = [];

  static void generateSellInstrument() {
    instrumentToSell.clear();
    for (int i = 0; i < 10; i++) {
      InstrumentModels brand =
          guitarModels[Random().nextInt(guitarModels.length)];
      int price = nextInt(brand.minPrice, brand.maxPrice);
      int inspiration = 0;
      if (price < 500) inspiration = nextInt(1, 50);
      if (price > 500 && price < 1200) inspiration = nextInt(50, 100);
      if (price > 1200 && price < 2000) inspiration = nextInt(80, 150);
      if (price > 2000) inspiration = nextInt(150, 200);
      instrumentToSell.add(InstrumentObject(
          inspiration: inspiration,
          brand: brand,
          price: price,
          popularity: nextInt((brand.popularity * 0.8).toInt(),
              (brand.popularity * 1.2).toInt())));
    }
    for (int i = 0; i < 10; i++) {
      InstrumentModels brand = bassModels[Random().nextInt(bassModels.length)];
      int price = nextInt(brand.minPrice, brand.maxPrice);
      int inspiration = 0;
      if (price < 500) inspiration = nextInt(1, 50);
      if (price > 500 && price < 1200) inspiration = nextInt(50, 100);
      if (price > 1200 && price < 2000) inspiration = nextInt(80, 150);
      if (price > 2000) inspiration = nextInt(150, 200);
      instrumentToSell.add(InstrumentObject(
          inspiration: inspiration,
          brand: brand,
          price: price,
          popularity: nextInt((brand.popularity * 0.8).toInt(),
              (brand.popularity * 1.2).toInt())));
    }
    instrumentToSell.add(signatureBass[Random().nextInt(signatureBass.length)]);
    instrumentToSell
        .add(guitarSignatures[Random().nextInt(guitarSignatures.length)]);
    instrumentToSell.shuffle();
  }

  static int nextInt(int min, int max) {
    int vretour = min + Random().nextInt(max - min);
    return vretour;
  }
}
