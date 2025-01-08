import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joystick_junkie/presentation/screens/games_list_screen.dart';
import 'package:joystick_junkie/service_provider.dart';

import 'core/constants/jj_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceProvider.registerDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Joystick Junkie',
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: JJColors.appBarBackgroundLight,
          iconTheme: const IconThemeData(color: JJColors.appBarIconColorDark),
          titleTextStyle: GoogleFonts.pressStart2p(
            fontSize: 16,
            color: JJColors.appBarTitleColor,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: JJColors.primary),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: JJColors.appBarBackgroundDark,
          iconTheme: const IconThemeData(color: JJColors.appBarIconColorDark),
          titleTextStyle: GoogleFonts.pressStart2p(
            fontSize: 16,
            color: JJColors.appBarTitleColorDark,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: JJColors.primaryDark),
        dividerColor: Colors.black,
      ),
      home: const GamesListScreen(),
    );
  }
}
