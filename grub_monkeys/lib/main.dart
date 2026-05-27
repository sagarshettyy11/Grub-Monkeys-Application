import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grub_monkeys/screens/profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: baseTheme.copyWith(
        textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
        primaryTextTheme: GoogleFonts.interTextTheme(baseTheme.primaryTextTheme),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontFamily: 'Inter'),
          labelStyle: TextStyle(fontFamily: 'Inter'),
        ),
      ),
      home: const AdminProfileScreen(),
    );
  }
}
