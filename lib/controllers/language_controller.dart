import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var locale = const Locale('en').obs;

  void changeLanguage(Locale newLocale) {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
  }
}