import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
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
            Color(0xcfdf9fff),
            Color(0xe2ebf0ff),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        height: double.maxFinite,
        width: double.maxFinite,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //header
              Text(
                'Tic Tac Toe',
                style: GoogleFonts.pacifico(
                    fontSize: 70,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple[400]),
              ),
              const SizedBox(height: 30),

              // image
              Image.asset(
                'assets/logo.png',
                height: 175,
                width: 175,
                color: Colors.redAccent,
              ),

              const SizedBox(height: 50),

              // player vs computer
              SizedBox(
                width: 275,
                height: 60,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      // move to single player game screen when pressed
                      Navigator.pushNamed(context, "/singleplayer");
                    },
                    child: Text(
                      "Single Player",
                      style: GoogleFonts.questrial(
                          fontSize: 40, color: Colors.white),
                    )),
              ),

              const SizedBox(height: 20),

              // player vs player
              Container(
                width: 275,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // move to multiplayer game screen when pressed
                    Navigator.pushNamed(context, '/multiplayer');
                  },
                  child: Text(
                    "Multiplayer",
                    style: GoogleFonts.questrial(
                        fontSize: 40, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                "Made by Rohit",
                style: GoogleFonts.cinzel(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
