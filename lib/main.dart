import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int aiScore = 0;
  int playerScore = 0;
  bool playerChose = false;
  String gameStatus = "";
  String aiMsg = "Computer is awaiting your choice...";
  String playerWeapon = "";
  String aiWeapon = "";
  String photoURL = "assets/images/spinner.gif";

  rpsAI() {
    const weapons = ['rock', 'paper', 'scissors'];
    int min = 0;
    int max = 3;

    Random rnd;
    rnd = Random();
    int r = min + rnd.nextInt(max - min);
    aiWeapon = weapons[r];
    setState(() {
      playerChose = true;
      if (weapons[r] == "rock") {
        photoURL = "assets/images/rock.png";
        aiMsg = "Computer picked Rock!";
      } else if (weapons[r] == "scissors") {
        photoURL = "assets/images/scissors.png";
        aiMsg = "Computer picked scissors!";
      } else {
        photoURL = "assets/images/paper.png";
        aiMsg = "Computer picked paper!";
      }
    });
    deepLearning(aiWeapon, playerWeapon);
  }

  deepLearning(aiWpn, playerWpn) {
    if (aiWpn == "rock" && playerWpn == "scissors" ||
        aiWpn == "scissors" && playerWpn == "rock") {
      winnerCheck("rock");
    } else if (aiWpn == "paper" && playerWpn == "rock" ||
        aiWpn == "rock" && playerWpn == "paper") {
      winnerCheck("paper");
    } else if (aiWpn == "scissors" && playerWpn == "paper" ||
        aiWpn == "paper" && playerWpn == "scissors") {
      winnerCheck("scissors");
    } else {
      setState(() {
        gameStatus = "DRAW!";
      });
    }
  }

  winnerCheck(winningWpn) {
    if (winningWpn == aiWeapon) {
      gameStatus = "COMPUTER WINS!!!";
      aiScore++;
    } else {
      gameStatus = "YOU WIN!!!";
      playerScore++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue[700],
          title: const Text('Rock Paper Scissors'),
          centerTitle: true),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (playerChose) Text(gameStatus),
          const SizedBox(height: 40),
          Text(aiMsg),
          Image(image: AssetImage(photoURL)),
          if (playerChose)
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    photoURL = "assets/images/scissors.png";
                    playerChose = false;
                    aiMsg = "Computer is awaiting your choice...";
                  });
                },
                child: const Text("Retry")),
          if (!playerChose)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      playerWeapon = "rock";
                      rpsAI();
                    },
                    child: Text("✊")),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      playerWeapon = "paper";
                      rpsAI();
                    },
                    child: const Text("📃")),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        playerWeapon = "scissors";
                        rpsAI();
                      });
                    },
                    child: const Text("✌")),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text("Your score:", style: TextStyle(fontSize: 12)),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text("Computer score:", style: TextStyle(fontSize: 12)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Text("$playerScore",
                      style: const TextStyle(fontSize: 50)),
                ),
                SizedBox(
                  child: Text("$aiScore", style: const TextStyle(fontSize: 50)),
                )
              ],
            ),
          )
        ]),
      ),
    ));
  }
}
