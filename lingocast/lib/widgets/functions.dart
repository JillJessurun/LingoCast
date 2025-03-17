import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

void navigate(context, int durationMilliseconds, StatefulWidget nextPage) {
  // navigate to other page
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(
        milliseconds: durationMilliseconds,
      ), // Animation duration
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );
}

String getLanguageNameFromPath(String path) {
  return p.basenameWithoutExtension(path).split('/').last;
}

String getLanguageCode(String language) {
  // Map of language names to ISO 639-1 codes
  final Map<String, String> languageMap = {
    'english': 'en',
    'spanish': 'es',
    'french': 'fr',
    'german': 'de',
    'dutch': 'nl',
    'italian': 'it',
    'portuguese': 'pt',
    'russian': 'ru',
    'chinese': 'zh-cn',
    'japanese': 'ja',
    'korean': 'ko',
    'arabic': 'ar',
    'hindi': 'hi',
    'swedish': 'sv',
    'norwegian': 'no',
    'danish': 'da',
    'polish': 'pl',
    'turkish': 'tr',
    'greek': 'el',
    'finnish': 'fi',
    'hungarian': 'hu',
    'czech': 'cs',
    'thai': 'th',
    'vietnamese': 'vi',
    'hebrew': 'he',
    'indonesian': 'id',
  };

  // normalize input (case-insensitive)
  language = language.toLowerCase();

  // return the corresponding code or an empty string if not found
  return languageMap[language] ?? '';
}
