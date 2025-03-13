import 'package:flutter/material.dart';
import 'package:lingocast/widgets/buttons.dart';
import 'package:lingocast/widgets/pageUI.dart';
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

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // drop down menu's
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: LanguageDropDown(),
                ),
                LanguageDropDown(),
              ],
            ),
          ),

          // mic button
          RoundButton(
            onPressed: () {
              print('Recording audio....');
            },
            icon: Icons.mic,
          ),
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
