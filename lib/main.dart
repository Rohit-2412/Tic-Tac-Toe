import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/multiplayer_game_screen.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';
import 'package:tic_tac_toe/screens/single_player_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/theme_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: themeProvider.themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/multiplayer': (context) => const MultiplayerGameScreen(),
        '/singleplayer': (context) => const SinglePlayerGameScreen(),
      },
    );
  }
}
