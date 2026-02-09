import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valentine_day/intro_page.dart';


void main() {
  runApp(const ValentineApp());
}

class ValentineApp extends StatelessWidget {
  const ValentineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'สำหรับเธอ ❤️',
      theme: ThemeData(
        textTheme: GoogleFonts.sarabunTextTheme(),
        fontFamily: GoogleFonts.sarabun().fontFamily,
        useMaterial3: true,
      ),
      home: const IntroPage(),
    );
  }
}

