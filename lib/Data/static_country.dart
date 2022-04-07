import 'package:minilife/Model/Country/country.dart';

class StaticCountry {
  static Country france = Country(
      "France",
      [
        "Léo",
        "Gabriel",
        "Raphaël",
        "Arthur",
        "Louis",
        "Jules",
        "Adam",
        "Lucas",
        "Hugo",
        "Gabin",
        "Paul",
        "Pierre",
        "Nathan",
        "Léon",
        "Marius",
        "Victor",
        "Martin",
        "Mathis",
        "Axel",
        "Marceau",
        "Valentin",
        "Malo",
        "Antoine",
        "Samuel",
        "Augustin",
        "Gaspard"
      ],
      [
        "Jade",
        "Louise",
        "Emma",
        "Alice",
        "Ambre",
        "Lina",
        "Rose",
        "Chloé",
        "Léa",
        "Anna",
        "Julia",
        "Lou",
        "Inès",
        "Léna",
        "Agathe",
        "Juliette",
        "Zoé",
        "Léonie",
        "Jeanne",
        "Iris",
        "Eva",
        "Adèle",
        "Victoire",
        "Manon",
      ],
      [
        "Martin",
        "Bernard",
        "Thomas",
        "Petit",
        "Robert",
        "Richard",
        "Durand",
        "Dubois",
        "Moreau",
        "Laurent",
        "Simon",
        "Michel",
        "Lefebvre",
        "Leroy",
        "Roux",
        "David",
        "Bertrand",
        "Morel",
        "Fournier",
        "Girard"
      ],
      true);
  static Country ireland = Country(
      "Ireland",
      [
        "Liam",
        "Nolan",
        "Lyam",
        "Malone",
        "Kylian",
        "Ryan",
        "Nolhan",
        "Kaylan",
        "Pharell",
        "Tayron",
        "Jack",
        "Nohlan",
        "Donovan",
        "Kilian",
        "Kiéran",
        "Cilian",
        "Keenan",
        "Declan",
        "Kévan",
        "Conan",
      ],
      [
        "Ella",
        "Kiara",
        "Norah",
        "Abby",
        "Shanna",
        "Kyara",
        "Kelly",
        "Ela",
        "Shana",
        "Aylin",
        "Tara",
        "Erin",
        "Ciara",
        "Maureen",
        "Ena",
        "Siobhan",
        "Darina",
        "Muriel",
        "Katie",
        "Kiliana",
      ],
      [
        "Murphy",
        "Kelly",
        "Byrne",
        "Ryan",
        "O'Brien",
        "Walsh",
        "O'Sullivan",
        "O'Connor",
        "Doyle",
        "McCarthy",
        "O'Neill",
        "Lynch",
        "O'Reilly",
        "Dunne",
        "McDonagh",
        "Brennan",
        "Fitzgerald",
        "Daly",
        "Kavanagh",
        "Nolan"
      ],
      true);
  static Country spain = Country(
      "Spain",
      [
        "Esteban",
        "Diego",
        "Ismaël",
        "Pablo",
        "Elian",
        "José",
        "Victor",
        "Valentin",
        "Hugo",
        "Rubén",
        "Martin",
        "Paco",
        "Mario",
        "Josue",
        "Lorenzo",
        "Bastien",
        "Manuel",
        "Romuald"
      ],
      [
        "Jade",
        "Mila",
        "Inès",
        "Nina",
        "Eva",
        "Lola",
        "Luna",
        "Alba",
        "Célia",
        "Salomé",
        "Cataléya",
        "Layana",
        "Valentina",
        "Paola",
        "Camila",
        "Paloma",
        "Esma	",
        "Amaya",
        "Lucia",
        "Castille",
        "Dania",
        "Angelina",
        "Carmen",
        "Paula",
        "Gabriela",
        "Gloria",
        "Rosa",
        "Catalina",
        "Luana"
      ],
      [
        "García",
        "Fernández",
        "González",
        "Rodríguez",
        "López",
        "Martínez",
        "Sánchez",
        "Pérez",
        "Martín",
        "Gómez",
        "Ruiz",
        "Hernández",
        "Jiménez",
        "Díaz"
      ],
      true);
  static Country belgium = Country(
      "Belgium",
      france.firstNameMale,
      france.firstNameFemale,
      [
        "Aakster",
        "Aaldenberg",
        "Aarden",
        "Aarle",
        "Achterberg",
        "Achthoven",
        "Adrichem",
        "Baardwijk",
        "Bakhuizen",
        "Berg",
        "Bezuindenhout",
        "Bouwmeester",
        "Bunschoten",
        "Cruyssen",
        "Dam"
      ],
      true);

  static List<Country> worldList = [france, ireland, spain, belgium];
}
