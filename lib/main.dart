import 'package:flutter/material.dart';
import 'package:tic_tac_toe_p2p/core/local_db/local_db.dart';
import 'package:tic_tac_toe_p2p/views/finding_devices_screen/finding_devices_screen.dart';
import 'package:tic_tac_toe_p2p/views/tic_tac_toe_screen/tic_tac_toe_screen.dart';
import 'core/assets/assets.dart';
import 'views/home_screen/home_screen.dart';
import 'views/splash_screen/splash_screen.dart';
import 'views/user_name_screen/user_name_screen.dart';

void main() async {
  await LocalDB.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Digitalt',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
