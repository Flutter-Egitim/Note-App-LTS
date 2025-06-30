import 'package:flutter/material.dart';
import 'package:note_app/constants/colors.dart';
import 'screens/home.dart' show Home;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Libertinus",
        colorScheme: ColorScheme.fromSeed(
          seedColor: backgroundColor,
          brightness: Brightness.light,
        ),
      ),
      home: Home(title: 'i-Note'),
    );
  }
}
