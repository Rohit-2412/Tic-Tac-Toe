import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tic_tac_toe/constants/colors.dart';
import 'package:tic_tac_toe/utils/gradient_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color(0xffF78418),
            Color(0xffF8565D),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        height: double.maxFinite,
        width: double.maxFinite,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              //header
              const Text(
                'Tic Tac Toe',
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(height: 40),

              // image
              Image.asset(
                'assets/logo.png',
                height: 175,
                width: 175,
                color: Colors.white,
              ),

              const SizedBox(height: 50),

              // player vs computer
              SizedBox(
                width: 300,
                height: 60,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    // move to single player game screen when pressed
                    Navigator.pushNamed(context, '/singleplayer');
                  },
                  child: const Text(
                    "Single Player",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // player vs player
              SizedBox(
                width: 300,
                height: 60,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    // move to multiplayer game screen when pressed
                    Navigator.pushNamed(context, '/multiplayer');
                  },
                  child: const Text(
                    "Multiplayer",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
