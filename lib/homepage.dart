import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pac_man/path.dart';
import 'package:pac_man/pixel.dart';
import 'package:pac_man/player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;
  int player = numberInRow * 15 + 1;

  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    88,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    98,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    24,
    26,
    28,
    30,
    35,
    37,
    38,
    39,
    41,
    46,
    52,
    57,
    59,
    61,
    63,
    70,
    72,
    78,
    79,
    80,
    81,
    83,
    84,
    85,
    86,
    100,
    101,
    102,
    103,
    105,
    106,
    107,
    108,
    114,
    116,
    123,
    125,
    127,
    129,
    134,
    140,
    145,
    147,
    148,
    149,
    151,
    156,
    158,
    160,
    162
  ];

  String direction = "right";

  void startGame() {
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      switch(direction){
        case "left":
          moveLeft();
          break;
        case "right":
          moveRight();
          break;
        case "up":
          moveUp();
          break;
        case "down":
          moveDown();
          break;
      }
    });
  }
  void moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }
  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveUp(){
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player-= numberInRow;
      });
    }
  }
  void moveDown(){
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player+= numberInRow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
                print(direction);
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
                print(direction);
              },
              child: Container(
                //color: Colors.red,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (BuildContext context, int index) {
                      if (player == index) {
                        switch(direction){
                          case "left":
                            return Transform.rotate(angle: pi, child: MyPlayer(),);
                            break;
                          case "right":
                            return MyPlayer();
                            break;
                          case "up":
                            return Transform.rotate(angle: 3*pi/2, child: MyPlayer(),);
                            break;
                          case "down":
                            return Transform.rotate(angle: pi/2, child: MyPlayer(),);
                            break;
                        }
                        return MyPlayer();
                      } else if (barriers.contains(index)) {
                        return MyPixel(
                          innerColor: Colors.blue[800],
                          outerColor: Colors.blue[900],
                          child: Text(""),
                        );
                      } else {
                        return MyPath(
                          innerColor: Colors.yellow,
                          outerColor: Colors.black,
                          child: Text(""),
                        );
                      }
                    }),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Score: ",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    GestureDetector(
                      child: Text(
                        "P L A Y ",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      onTap: startGame,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
