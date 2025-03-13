import 'package:flutter/material.dart';
import 'package:lingocast/widgets/buttons.dart';
import 'package:lingocast/widgets/pageUI.dart';
import 'package:lingocast/widgets/variables.dart';
import 'package:lingocast/widgets/widgets.dart';

// translate page
class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  @override
  Widget build(BuildContext context) {
    // basic UI
    return Stack(
      children: [
        // page UI
        PageUI(),

        // page content
        Content(),
      ],
    );
  }
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  // Function to update language
  void updateLanguage(String newLanguage1) {
    setState(() {
      currentLanguagePath1 = newLanguage1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drop down menus
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: LanguageDropDown(
                    onLanguageSelected: updateLanguage,
                    firstFlag: currentLanguagePath1, // Pass the callback here
                  ),
                ),
                LanguageDropDown(
                  onLanguageSelected: (language) {
                    setState(() {
                      currentLanguagePath2 = language;
                    });
                  },
                  firstFlag: currentLanguagePath2,
                ),
              ],
            ),
          ),

          // Mic button
          RoundButton(
            onPressed: () {
              print('Recording audio....');
            },
            icon: Icons.mic,
          ),
          /*
          // Language display
          Text(
            currentLanguagePath1,
            style: TextStyle(
              color: textColour,
              fontSize: 12,
              fontFamily: "TextFont",
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),

          Text(
            currentLanguagePath2,
            style: TextStyle(
              color: textColour,
              fontSize: 12,
              fontFamily: "TextFont",
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          */
        ],
      ),
    );
  }
}

/*
Text(
  'Start recording!',
  style: TextStyle(
    color: textColour,
    fontSize: 26,
    fontFamily: "TextFont",
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  ),
),

// smiley
Padding(
  padding: const EdgeInsets.only(left: 20),
  child: Image.asset(
    'assets/images/smiley.png',
    width: 20,
    height: 20,
  ),
),
*/
