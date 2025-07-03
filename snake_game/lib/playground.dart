import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/game/food.dart';
import 'package:snake_game/game/snake.dart';

class PlayGround extends StatefulWidget {
  const PlayGround({super.key});

  @override
  State<PlayGround> createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  final int squaresPerRow = 30;
  final int squaresPerCol = 60;
  late Snake snake;
  late Food food;
  @override
  void initState() {
    super.initState();
    snake = Snake();
    spawnFood(); // create a food not on the snake
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: AspectRatio(
                aspectRatio: squaresPerRow / squaresPerCol,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: squaresPerRow,
                  ),
                  itemCount: squaresPerRow * squaresPerCol,
                  itemBuilder: (BuildContext context, int index) {
                    int x = index % squaresPerRow;
                    int y = (index / squaresPerRow).floor();
                    final cell = Offset(x.toDouble(), y.toDouble());

                    final isSnake = snake.body.contains(cell);
                    final isFood = cell == food.position;

                    Color color;
                    if (isSnake) {
                      color = Colors.green;
                    } else if (isFood) {
                      color = Colors.red;
                    } else {
                      color = Colors.grey[800]!;
                    }
                    return Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void spawnFood() {
    final random = Random();

    while (true) {
      final x = random.nextInt(squaresPerRow);
      final y = random.nextInt(squaresPerCol);
      final candidate = Offset(x.toDouble(), y.toDouble());

      if (!snake.body.contains(candidate)) {
        food = Food(position: candidate);
        break;
      }
    }
  }
}
