import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lingocast/widgets/buttons.dart';
import 'package:lingocast/widgets/functions.dart';
import 'package:lingocast/widgets/pageUI.dart';
import 'package:lingocast/widgets/variables.dart';
import 'package:lingocast/widgets/widgets.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simplytranslate/simplytranslate.dart';
import 'package:flutter_langdetect/flutter_langdetect.dart' as langdetect;
import 'package:flutter_sound/flutter_sound.dart';

final st = SimplyTranslator(EngineType.google);
final String tempText =
    "I love doing a backflip into a trashcan full of glass.";
String translated = tempText;
bool isTranslating = false;

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
  // player
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  // recorder
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  String? recordedFilePath;

  @override
  void initState() {
    super.initState();

    initRecorder();

    // Listen for when audio playback is complete
    audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false; // Reset to play icon when finished
      });
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();

    super.dispose();
  }

  // init record
  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  // record
  Future record() async {
    if (!isRecorderReady) return;
    //await recorder.startRecorder(toFile: 'audio');

    await recorder.startRecorder(toFile: 'audio'); // Starts recording
    print("Recording started...");
  }

  // stop record
  Future stop() async {
    if (!isRecorderReady) return;
    //await recorder.stopRecorder();

    recordedFilePath = await recorder.stopRecorder(); // Retrieves file path
    print('Recorded file path: $recordedFilePath');
  }

  Future<void> playRecordedAudio() async {
    if (recordedFilePath == null) {
      print("No audio recorded yet.");
      return;
    }

    if (isPlaying) {
      await audioPlayer.pause();
      setState(() => isPlaying = false);
    } else {
      await audioPlayer.play(UrlSource(recordedFilePath!));
      setState(() => isPlaying = true);
    }
  }

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
                    firstFlag: currentLanguagePath1,
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

          // player
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: buttonColour,
              shape: BoxShape.circle,
            ),
            child: Material(
              elevation: buttonElevation,
              shadowColor: Colors.black,
              shape: const CircleBorder(),
              color: iconButtonColour,
              child: Center(
                child: IconButton(
                  onPressed: () async {
                    if (recordedFilePath == null) {
                      print("No audio recorded yet.");
                      return;
                    }

                    if (isPlaying) {
                      await audioPlayer.stop();
                      isPlaying = false;
                    } else {
                      await audioPlayer.play(UrlSource(recordedFilePath!));
                      isPlaying = true;
                    }

                    setState(() {});
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: buttonIconColour,
                  ),
                  iconSize: iconSize,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ),

          SizedBox(height: 10),

          // Mic button
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: buttonColour,
              shape: BoxShape.circle,
            ),
            child: Material(
              elevation: buttonElevation,
              shadowColor: Colors.black,
              shape: const CircleBorder(),
              color: iconButtonColour,
              child: Center(
                child: IconButton(
                  onPressed: () async {
                    if (recorder.isRecording) {
                      await stop();
                    } else {
                      await record();
                    }

                    setState(() {});
                  },
                  icon: Icon(
                    recorder.isRecording ? Icons.stop : Icons.mic,
                    color: buttonIconColour,
                  ),
                  iconSize: iconSize,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ),

          // temporary translate button
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: RoundButton(
              onPressed: () async {
                setState(() {
                  isTranslating = true; // switch to loading indicator
                });

                // GET CURRENT LANGUAGES
                String language1 = getLanguageNameFromPath(
                  currentLanguagePath1,
                );
                String language2 = getLanguageNameFromPath(
                  currentLanguagePath2,
                );

                // DETECT CURRENT LANGUAGE
                await langdetect.initLangDetect();
                final language = langdetect.detect(translated);

                //print('Translate from: $language');
                //String code = getLanguageCode(language2);
                //print('Translate to: $code');

                // TRANSLATE
                var newTranslation = await st.translateSimply(
                  tempText,
                  to: getLanguageCode(language2),
                  instanceMode: InstanceMode.Random,
                );

                // SET TRANSLATED TEXT
                setState(() {
                  translated = newTranslation.translations.text;
                  isTranslating = false; // switch to translate icon again
                });
              },
              icon: isTranslating ? Icons.autorenew : Icons.translate,
            ),
          ),

          // temporary text
          Text(
            textAlign: TextAlign.center,
            translated,
            style: TextStyle(
              color: textColour,
              fontSize: 12,
              fontFamily: "TextFont",
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
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
