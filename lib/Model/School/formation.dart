import 'package:minilife/Model/School/degree.dart';

class Formation {
  final String nom;
  final Degree degree;
  final int duration;
  int? ageGraduate;

  Formation({
    required this.nom,
    required this.degree,
    required this.duration,
  });

  void setGraduate(int age) {
    ageGraduate = age + duration;
  }

  int yearsLeft(int age) {
    return ageGraduate! - age;
  }
}
