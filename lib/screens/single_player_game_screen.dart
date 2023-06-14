import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/constants/colors.dart';
import 'package:tic_tac_toe/utils/gradient_text.dart';

class SinglePlayerGameScreen extends StatefulWidget {
  const SinglePlayerGameScreen({super.key});

  @override
  State<SinglePlayerGameScreen> createState() => _SinglePlayerGameScreenState();
}

class _SinglePlayerGameScreenState extends State<SinglePlayerGameScreen> {
  bool userTurn = true;
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  List<int> magicSquare = [2, 7, 6, 9, 5, 1, 4, 3, 8];
  // [2, 7, 6,
  // 9, 5, 1,
  // 4, 3, 8];
  Map<int, int> magicSquareMap = {
    2: 0,
    7: 1,
    6: 2,
    9: 3,
    5: 4,
    1: 5,
    4: 6,
    3: 7,
    8: 8
  };
  List<int> winningIndex = [];
  String result = "";
  int userScore = 0;
  int computeScore = 0;
  bool stopped = false;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  int attempts = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.white,
          body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // score in a box with border
                      Container(
                        height: 50,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.grey.withOpacity(.2)),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 2,
                                offset: Offset(0, 2),
                                color: Colors.white)
                          ],
                        ),
                        child: Center(
                            child: Text(
                          userScore.toString(),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )),
                      ),

                      // image and name
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "O",
                            style: GoogleFonts.abrilFatface(
                              fontSize: 70,
                              color: CustomColors.redColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // board
              Expanded(
                flex: 3,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(2, -2),
                              ),
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(2, 2),
                              )
                            ],
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            board[index],
                            style: GoogleFonts.varelaRound(
                                fontSize: 60,
                                fontWeight: FontWeight.w900,
                                color: (board[index] == 'O')
                                    ? CustomColors.redColor
                                    : CustomColors.blueColor),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // image and name
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // image
                              // o image
                              Text(
                                "X",
                                style: GoogleFonts.abrilFatface(
                                  fontSize: 70,
                                  color: CustomColors.blueColor,
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(.2)),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                    color: Colors.white)
                              ],
                            ),
                            child: Center(
                              child: Text(
                                computeScore.toString(),
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        result.isNotEmpty ? result : "",
                        style: TextStyle(
                            fontSize: 30,
                            color: result == 'O Wins'
                                ? Colors.pinkAccent
                                : Colors.blueAccent,
                            fontWeight: FontWeight.w600),
                      ),
                      buildTimer(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    ));
  }

  Widget buildTimer() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? Center(
            child: (SizedBox(
              height: 60,
              width: 60,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                      value: 1 - seconds / maxSeconds,
                      valueColor: AlwaysStoppedAnimation(Colors.green[400]),
                      strokeWidth: 7,
                      backgroundColor: Colors.green.withOpacity(.4)
                      // CustomColors.firstGradientColor.withOpacity(.35),
                      ),
                  Center(
                    child: Text(
                      seconds.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )),
          )
        : (ElevatedButton(
            onPressed: () {
              setState(() {
                userTurn = true;
                startTimer();
                board = ['', '', '', '', '', '', '', '', ''];
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
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
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

  // on dispose cancel the timer
  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSeconds;
  }

  // update user click
  void _tapped(index) {
    final isRunning = timer == null ? false : timer!.isActive;
    if (result == '' && isRunning) {
      setState(() {
        if (userTurn && board[index] == '') {
          board[index] = 'O';
          userTurn = false;
          if (!_checkWinner("O")) {
            nextTurn();
          }
        }
      });
    }
  }

  // function to update score
  void _updateScore(winner) {
    if (winner == "O") {
      userScore++;
    } else if (winner == "X") {
      computeScore++;
    }
  }

  void nextTurn() {
    // is game tied
    // check if there is any empty box
    if (!board.contains('')) {
      stopTimer();
      setState(() {
        result = "Game Tied";
      });
      return;
    }
    // if comp can win, make move and win
    // otherwise if user can win, block user
    if (canWin("X") || canWin("O")) {
      return;
    }
    // else make a move at any random box
    randomMove();
  }

  bool canWin(String player) {
    if (player == "X") {
      // check if diff of 15 and any two moves of computer is between 1 and 9
      for (var i = 0; i < 9; i++) {
        for (var j = i + 1; j < 9; j++) {
          if (board[i] == 'X' && board[j] == 'X') {
            final diff = 15 - (magicSquare[i] + magicSquare[j]);
            if (diff > 0 && diff < 10) {
              final index = magicSquareMap[diff];
              if (board[index!] == '') {
                setState(() {
                  board[index] = 'X';
                  result = "X Wins";
                  winningIndex = [i, j, index];
                  _updateScore("X");
                  stopTimer();
                });
                return true;
              }
            }
          }
        }
      }
      return false;
    } else {
      // check if diff of 15 and any two moves of user is between 1 and 9
      for (var i = 0; i < 9; i++) {
        for (var j = i + 1; j < 9; j++) {
          if (board[i] == 'O' && board[j] == 'O') {
            final diff = 15 - (magicSquare[i] + magicSquare[j]);
            if (diff > 0 && diff < 10) {
              final index = magicSquareMap[diff];
              if (board[index!] == '') {
                setState(() {
                  board[index] = 'X';
                  userTurn = true;
                });
                return true;
              }
            }
          }
        }
      }
      return false;
    }
  }

  bool _checkWinner(String player) {
    // o turn
    if (player == "O") {
      // if sum of three boxes is 15 then o wins
      for (var i = 0; i < 9; i++) {
        for (var j = i + 1; j < 9; j++) {
          for (var k = j + 1; k < 9; k++) {
            if (board[i] == "O" && board[j] == "O" && board[k] == "O") {
              if (magicSquare[i] + magicSquare[j] + magicSquare[k] == 15) {
                winningIndex = [i, j, k];
                setState(() {
                  result = 'O Wins';
                  _updateScore('O');
                  stopTimer();
                });
                return true;
              }
            }
          }
        }
      }
    } else {
      // x turn
      // if sum of three boxes is 15 then x wins
      for (var i = 0; i < 9; i++) {
        for (var j = i + 1; j < 9; j++) {
          for (var k = j + 1; k < 9; k++) {
            if (board[i] == "X" && board[j] == "X" && board[k] == "X") {
              if (magicSquare[i] + magicSquare[j] + magicSquare[k] == 15) {
                winningIndex = [i, j, k];
                setState(() {
                  result = 'X Wins';
                  _updateScore('X');
                  stopTimer();
                });
                return true;
              }
            }
          }
        }
      }
    }

    return false;
  }

  void randomMove() {
    // first check for center box
    if (board[4] == '') {
      setState(() {
        board[4] = 'X';
        userTurn = true;
      });
      return;
    }

    // check for edges
    final edges = [1, 3, 5, 7];
    for (var i = 0; i < edges.length; i++) {
      if (board[edges[i]] == '') {
        setState(() {
          board[edges[i]] = 'X';
          userTurn = true;
        });
        return;
      }
    }

    // check for corners
    final corners = [0, 2, 6, 8];
    for (var i = 0; i < corners.length; i++) {
      if (board[corners[i]] == '') {
        setState(() {
          board[corners[i]] = 'X';
          userTurn = true;
        });
        return;
      }
    }
  }
}
