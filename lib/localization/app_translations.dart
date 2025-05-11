import 'package:flutter/material.dart';

class AppTranslations {
  static List<String> languages = ['en', 'hi', 'te'];

  static Map<String, Map<String, String>> translations = {
    'en': {
      'appTitle': 'Uploader App',
      'uploadTab': 'Upload',
      'historyTab': 'History',
      'noFiles': 'No files found',
      'language': 'Language',
      'selectFile': 'Select File',
      'useCamera': 'Use Camera',
      'uploading': 'Uploading...',
      'uploadButton': 'Upload',
      'uploadSuccess': 'File uploaded successfully!',
      'welcomeMessage': 'Welcome to Uploader',
      'descriptionMessage': 'Upload and manage your files with ease',
    },
    'hi': {
      'appTitle': 'अपलोडर ऐप',
      'uploadTab': 'अपलोड करें',
      'historyTab': 'इतिहास',
      'noFiles': 'कोई फ़ाइल नहीं मिली',
      'language': 'भाषा',
      'selectFile': 'फ़ाइल चुनें',
      'useCamera': 'कैमरा उपयोग करें',
      'uploading': 'अपलोड हो रहा है...',
      'uploadButton': 'अपलोड',
      'uploadSuccess': 'फ़ाइल सफलतापूर्वक अपलोड की गई!',
      'welcomeMessage': 'अपलोडर में आपका स्वागत है',
      'descriptionMessage': 'अपनी फ़ाइलें आसानी से अपलोड और प्रबंधित करें',
    },
    'te': {
      'appTitle': 'అప్‌లోడర్ యాప్',
      'uploadTab': 'అప్‌లోడ్',
      'historyTab': 'చరిత్ర',
      'noFiles': 'ఫైళ్లు ఏవీ కనుగొనబడలేదు',
      'language': 'భాష',
      'selectFile': 'ఫైల్ ఎంచుకోండి',
      'useCamera': 'కెమెరా ఉపయోగించండి',
      'uploading': 'అప్‌లోడ్ అవుతోంది...',
      'uploadButton': 'అప్‌లోడ్',
      'uploadSuccess': 'ఫైల్ విజయవంతంగా అప్‌లోడ్ అయింది!',
      'welcomeMessage': 'అప్‌లోడర్‌కు స్వాగతం',
      'descriptionMessage': 'మీ ఫైళ్లను సులభంగా అప్‌లోడ్ చేయండి మరియు నిర్వహించండి',
    },
  };

  static String translate(String key, Locale locale) {
    return translations[locale.languageCode]?[key] ?? translations['en']![key]!;
  }
}