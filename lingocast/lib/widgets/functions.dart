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
