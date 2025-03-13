import 'package:flutter/material.dart';
import 'package:lingocast/widgets/variables.dart';

// simple button with text
class SimpleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;

  const SimpleButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColour,
        foregroundColor: buttonTextColour,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            buttonRounding,
          ), // Rounded corners
        ),
        elevation: buttonElevation,
        shadowColor: Colors.black,
        //minimumSize: const Size(150, 50),
      ),
      child: Text(buttonText),
    );
  }
}

// simple button with icon
class CustomIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String currentLanguage; // accept currentLanguage as a parameter

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.currentLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColour,
        foregroundColor: buttonTextColour,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRounding),
        ),
        elevation: buttonElevation,
        shadowColor: Colors.black,
        minimumSize: const Size(70, 50),
      ),
      child: Image.asset(
        currentLanguage,
        height: iconSize,
      ), // Display the current language icon
    );
  }
}

// round icon button
class RoundButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;

  const RoundButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(color: buttonColour, shape: BoxShape.circle),
      child: Material(
        elevation: buttonElevation,
        shadowColor: Colors.black,
        shape: const CircleBorder(),
        color: iconButtonColour,
        child: Center(
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: buttonTextColour),
            iconSize: iconSize,
            padding: EdgeInsets.zero, // removes internal padding
            constraints: const BoxConstraints(), // removes extra constraints
          ),
        ),
      ),
    );
  }
}

// simple button with icon
class LanguageButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String languageIconPath;
  final String languageName;

  const LanguageButton({
    super.key,
    required this.onPressed,
    required this.languageIconPath,
    required this.languageName,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColour,
        foregroundColor: buttonTextColour,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            buttonRounding,
          ), // Rounded corners
        ),
        elevation: buttonElevation,
        shadowColor: Colors.black,
        //fixedSize: const Size(90, 50),
      ),
      child: Row(
        children: [
          // language icon
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset(languageIconPath, width: iconSize),
          ),

          // language text
          Text(
            languageName,
            style: TextStyle(
              color: textColour,
              fontSize: 15,
              fontFamily: "TextFont",
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
