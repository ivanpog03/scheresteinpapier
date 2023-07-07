import 'dart:io';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:rock_paper_scisor_game/screens/results_screen.dart';
import 'package:rock_paper_scisor_game/utilis/game.dart';
import 'package:rock_paper_scisor_game/widgets/button.dart';
import 'package:sensors/sensors.dart';
import 'package:shake/shake.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

void initState(){
  super.initState();

  accelerometerEvents.listen((event) {
    if(event.x.abs()>10||event.y.abs()>10||event.z.abs()>10){
      setState(() {
        Random random = new Random();
    int choice = random.nextInt(3);
    if(choice==1){
      HapticFeedback.heavyImpact();
      //Vibration.vibrate(duration: 5000);
      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(GameChoice("Rock")),
                            ),
                          );
    }else if(choice==2){
            HapticFeedback.heavyImpact();
          // Vibration.vibrate(duration: 5000);

      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(GameChoice("Scisors")),
                            ),
                          );
    }else{
            HapticFeedback.heavyImpact();
           //Vibration.vibrate(duration: 5000);

      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(GameChoice("Paper")),
                            ),
                          );
    }
      });
    }
  });
}

  @override
  Widget build(BuildContext context) {
    double btnWidth = MediaQuery.of(context).size.width / 2 - 40;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 11, 58, 2),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 255, 255, 255), width: 5.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SCORE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${Game.gameScore}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /* Setting the Game play pad */
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: MediaQuery.of(context).size.width / 2 -
                          (btnWidth / 2) -
                          20, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Rock",
                        child: gameBtn(() {
                          print("you choosed rock");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(GameChoice("Rock")),
                            ),
                          );
                        }, "assets/rock_btn.png", btnWidth),
                      ),
                    ),
                    Positioned(
                      top: btnWidth,
                      left: MediaQuery.of(context).size.width / 2 -
                          btnWidth -
                          40, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Scisors",
                        child: gameBtn(() {
                          print("you choosed scisors");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(GameChoice("Scisors")),
                            ),
                          );
                        }, "assets/scisor_btn.png", btnWidth),
                      ),
                    ),
                    Positioned(
                      top: btnWidth,
                      right: MediaQuery.of(context).size.width / 2 -
                          btnWidth -
                          40, // we soustract the half of ther widget size and the half of the padding,
                      child: Hero(
                        tag: "Paper",
                        child: gameBtn(() {
                          print("you choosed paper");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GameScreen(GameChoice("Paper")),
                            ),
                          );
                        }, "assets/paper_btn.png", btnWidth),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Text(
              "Rock, Paper, Scissors...",
              style: TextStyle(color: Colors.white, fontSize: 36.0),
            )
          ],
        ),
      ),
    );
  }
}
