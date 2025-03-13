import 'package:flutter/material.dart';
import 'package:lingocast/pages/translate_page.dart';
import 'package:lingocast/widgets/buttons.dart';
import 'package:lingocast/widgets/functions.dart';
import 'package:lingocast/widgets/variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage(title: 'Flutter Demo Home Page'));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColour,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LingoCast',
              style: TextStyle(
                color: terracottaColour,
                fontSize: 50,
                fontFamily: "TitleFont",
                fontWeight: FontWeight.normal,
              ),
            ),

            // start button
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SimpleButton(
                onPressed: () {
                  navigate(context, 200, TranslatePage());
                },
                buttonText: 'Start',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
