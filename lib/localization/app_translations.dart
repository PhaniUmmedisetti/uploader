import 'package:flutter/material.dart';

class AppTranslations {
  static const supportedLocales = [
    Locale('en'),
    Locale('hi'),
    Locale('te'),
  ];

  static const _translations = {
    'en': {
      'appTitle': 'Uploader App',
      'uploadTab': 'Upload',
      'historyTab': 'History',
      'selectFile': 'Select File',
      'useCamera': 'Use Camera',
      'uploadButton': 'Upload',
      'uploading': 'Uploading...',
      'uploadSuccess': 'File uploaded successfully!',
      'uploadFailed': 'Upload failed. Please try again.',
      'noFiles': 'No files uploaded yet.',
      'language': 'Language',
      'welcomeMessage': 'Welcome to Uploader',
      'descriptionMessage': 'Upload and manage your files with ease',
    },
    'hi': {
      'appTitle': 'अपलोडर ऐप',
      'uploadTab': 'अपलोड',
      'historyTab': 'इतिहास',
      'selectFile': 'फ़ाइल चुनें',
      'useCamera': 'कैमरा उपयोग करें',
      'uploadButton': 'अपलोड करें',
      'uploading': 'अपलोड हो रहा है...',
      'uploadSuccess': 'फ़ाइल सफलतापूर्वक अपलोड हो गई!',
      'uploadFailed': 'अपलोड विफल। कृपया पुनः प्रयास करें।',
      'noFiles': 'अभी तक कोई फ़ाइल अपलोड नहीं की गई।',
      'language': 'भाषा',
      'welcomeMessage': 'अपलोडर में आपका स्वागत है',
      'descriptionMessage': 'अपनी फ़ाइलें आसानी से अपलोड और प्रबंधित करें',
    },
    'te': {
      'appTitle': 'అప్‌లోడర్ యాప్',
      'uploadTab': 'అప్‌లోడ్',
      'historyTab': 'చరిత్ర',
      'selectFile': 'ఫైల్ ఎంచుకోండి',
      'useCamera': 'కెమెరా ఉపయోగించండి',
      'uploadButton': 'అప్‌లోడ్ చేయండి',
      'uploading': 'అప్‌లోడ్ అవుతోంది...',
      'uploadSuccess': 'ఫైల్ విజయవంతంగా అప్‌లోడ్ అయింది!',
      'uploadFailed': 'అప్‌లోడ్ విఫలమైంది. దయచేసి మళ్లీ ప్రయత్నించండి.',
      'noFiles': 'ఇంకా ఏ ఫైళ్లు అప్‌లోడ్ కాలేదు।',
      'language': 'భాష',
      'welcomeMessage': 'అప్‌లోడర్‌కు స్వాగతం',
      'descriptionMessage': 'మీ ఫైళ్లను సులభంగా అప్‌లోడ్ చేయండి మరియు నిర్వహించండి',
    },
  };

  static String translate(String key, Locale locale) {
    final languageCode = locale.languageCode;
    return _translations[languageCode]?[key] ?? _translations['en']![key]!;
  }
}