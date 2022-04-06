import 'package:flutter/material.dart';
import 'package:minilife/Model/Milieu/milieu.dart';

class StaticMilieu {
  static Milieu milieuTechnology =
      Milieu("Technology", const Icon(Icons.code_outlined));

  static Milieu milieuRestaurant =
      Milieu("Restauration", const Icon(Icons.food_bank_outlined));

  static Milieu milieuEconomy =
      Milieu("Economy", const Icon(Icons.monetization_on));

  static Milieu milieuJournalism =
      Milieu("Journalism", const Icon(Icons.camera_enhance_outlined));
}
