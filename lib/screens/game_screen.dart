import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants/colors.dart';
import 'package:tic_tac_toe/utils/gradient_text.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static var textStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    letterSpacing: 3,
  );

  bool oTurn = true;
  List<String> list = ['', '', '', '', '', '', '', '', ''];
  List<int> winningIndex = [];
  String result = "";
  int oScore = 0;
  int xScore = 0;
  bool stopped = false;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  int attempts = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(.95),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Tic Tac Toe",
                        style: TextStyle(color: Colors.orange, fontSize: 30),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Turn: ${oTurn ? 'O' : 'X'}",
                        style: const TextStyle(
                            fontSize: 20,
                            color: CustomColors.firstGradientColor,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Player O",
                                    style: TextStyle(fontSize: 20)),
                                Text(
                                  oScore.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: CustomColors.blueColor1,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text("Player X",
                                    style: TextStyle(fontSize: 20)),
                                Text(
                                  xScore.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: CustomColors.redColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ]),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // board
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _tapped(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: winningIndex.contains(index)
                                  ? Border.all(color: Colors.black87, width: 2)
                                  : null,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(5, 5))
                              ],
                              color: Colors.white),
                          child: Center(
                            child: GradientText(
                              // 'X',
                              list[index],
                              style: const TextStyle(fontSize: 40),
                              gradient: (list[index] == 'O')
                                  ? LinearGradient(colors: [
                                      CustomColors.redColor1,
                                      CustomColors.redColor2,
                                      CustomColors.redColor1,
                                      CustomColors.redColor2,
                                    ])
                                  : LinearGradient(colors: [
                                      CustomColors.blueColor,
                                      CustomColors.blueColor1,
                                    ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          result.isNotEmpty ? "Result: $result" : "",
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.pinkAccent,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 20),
                        buildTimer()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? Center(
            child: (SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 1 - seconds / maxSeconds,
                    valueColor: const AlwaysStoppedAnimation(
                        CustomColors.firstGradientColor),
                    strokeWidth: 7,
                    backgroundColor:
                        CustomColors.firstGradientColor.withOpacity(.35),
                  ),
                  Center(
                    child: Text(
                      seconds.toString(),
                      style: const TextStyle(
                          color: Colors.blueAccent, fontSize: 30),
                    ),
                  )
                ],
              ),
            )),
          )
        : (ElevatedButton(
            onPressed: () {
              setState(() {
                startTimer();
                list = ['', '', '', '', '', '', '', '', ''];
                result = "";
                attempts++;
                winningIndex = [];
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
            child: Text(
              attempts == 0 ? "Start" : "Play Again!",
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ));
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSeconds;
  }

  void _tapped(index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (result == '' && isRunning) {
      setState(() {
        if (oTurn && list[index] == '') {
          list[index] = 'O';
          oTurn = !oTurn;
        } else if (!oTurn && list[index] == '') {
          list[index] = 'X';
          oTurn = !oTurn;
        }
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    // 1st row
    if (list[0] == list[1] && list[0] == list[2] && list[0] != '') {
      setState(() {
        result = "${list[0]} wins";
        winningIndex = [0, 1, 2];
      });
    }

    // 2nd row
    if (list[3] == list[4] && list[3] == list[5] && list[3] != '') {
      setState(() {
        result = "${list[3]} wins";
        winningIndex = [3, 4, 5];
      });
    }

    // 3rd row
    if (list[6] == list[7] && list[6] == list[8] && list[6] != '') {
      setState(() {
        result = "${list[6]} wins";
        winningIndex = [6, 7, 8];
      });
    }

    // 1st column
    if (list[0] == list[3] && list[0] == list[6] && list[0] != '') {
      setState(() {
        result = "${list[0]} wins";
        winningIndex = [0, 3, 6];
      });
    }

    // 2nd column
    if (list[1] == list[4] && list[1] == list[7] && list[1] != '') {
      setState(() {
        result = "${list[1]} wins";
        winningIndex = [1, 4, 7];
      });
    }

    // 3rd column
    if (list[2] == list[5] && list[2] == list[8] && list[2] != '') {
      setState(() {
        result = "${list[2]} wins";
        winningIndex = [2, 5, 8];
      });
    }

    // 1st diagonal
    if (list[0] == list[4] && list[0] == list[8] && list[0] != '') {
      setState(() {
        result = "${list[0]} wins";
        winningIndex = [0, 4, 8];
      });
    }

    // 2nd diagonal
    if (list[2] == list[4] && list[2] == list[6] && list[2] != '') {
      setState(() {
        result = "${list[2]} wins";
        winningIndex = [2, 4, 6];
      });
    }

    int filled = 0;

    for (int i = 0; i < 9; i++) {
      if (list[i] != '') {
        filled++;
      }
    }

    if (filled == 9 && result == '') {
      setState(() {
        result = "Game Draw";
        return;
      });
    }

    if (oTurn && result == "X wins") {
      _updateScore('X');
    } else if (!oTurn && result == "O wins") {
      _updateScore('O');
    }

    if (result == "Game Draw" || result == "X wins" || result == "O wins") {
      stopTimer();
    }
  }

  void _updateScore(winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }
}
