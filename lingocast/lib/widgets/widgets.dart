import 'package:flutter/material.dart';
import 'package:lingocast/widgets/buttons.dart';
import 'package:lingocast/widgets/functions.dart';
import 'package:lingocast/widgets/variables.dart';

// Define a list of language image paths
final List<String> languagePaths = [
  "assets/flags/English.jpg",
  "assets/flags/Spanish.png",
  "assets/flags/French.png",
  "assets/flags/German.png",
  "assets/flags/Portugese.png",
  "assets/flags/Dutch.png",
  "assets/flags/Russian.png",
  "assets/flags/Greek.png",
  "assets/flags/Chinese.png",
  "assets/flags/Japanese.png",
  "assets/flags/Korean.png",
];

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({super.key});

  @override
  _LanguageDropDownState createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  String currentLanguage = "assets/flags/English.jpg"; // Default language

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final Offset offset = button.localToGlobal(Offset.zero);
        _showMenu(context, offset);
      },
      currentLanguage: currentLanguage, // Pass the current language here
    );
  }

  void _showMenu(BuildContext context, Offset offset) async {
    await showMenu(
      context: context,
      color: appColour,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        offset.dx + 1,
        offset.dy + 1,
      ),
      items: [
        PopupMenuItem(
          enabled: true,
          child: SizedBox(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(languagePaths.length, (index) {
                  final String languagePath = languagePaths[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: LanguageButton(
                      onPressed: () {
                        setState(() {
                          currentLanguage = languagePath; // Update the language
                        });
                        Navigator.pop(context); // Close the popup
                      },
                      languageIconPath: languagePath,
                      languageName: getLanguageNameFromPath(languagePath),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
