import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/game/direction.dart';
import 'package:snake_game/game/food.dart';
import 'package:snake_game/game/snake.dart';

class PlayGround extends StatefulWidget {
  const PlayGround({super.key});

  @override
  State<PlayGround> createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  Timer? gameLoop;
  final int squaresPerRow = 30;
  final int squaresPerCol = 60;
  late Snake snake;
  late Food food;
  Direction currentDirection = Direction.up;

  @override
  void initState() {
    super.initState();
    snake = Snake();
    spawnFood(); // create a food not on the snake
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy < 0 &&
                    currentDirection != Direction.down) {
                  setState(() {
                    currentDirection = Direction.up;
                  });
                } else if (details.delta.dy > 0 &&
                    currentDirection != Direction.up) {
                  setState(() {
                    currentDirection = Direction.down;
                  });
                }
              },

              onHorizontalDragUpdate: (details) {
                if (details.delta.dx < 0 &&
                    currentDirection != Direction.right) {
                  setState(() {
                    currentDirection = Direction.left;
                  });
                } else if (details.delta.dx > 0 &&
                    currentDirection != Direction.left) {
                  setState(() {
                    currentDirection = Direction.right;
                  });
                }
              },
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
      //while (true) => Keep trying until we find a valid position not on the snake
      final x = random.nextInt(squaresPerRow);
      final y = random.nextInt(squaresPerCol);
      final candidate = Offset(x.toDouble(), y.toDouble());

      if (!snake.body.contains(candidate)) {
        food = Food(position: candidate);
        break;
      }
    }
  }

  void startGame() {
    gameLoop = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        moveSnake();
      });
    });
  }

  void moveSnake() {
    final head = snake.body.first;
    Offset newHead;
    switch (currentDirection) {
      case Direction.up:
        newHead = Offset(head.dx, head.dy - 1);
        break;
      case Direction.down:
        newHead = Offset(head.dx, head.dy + 1);
        break;
      case Direction.left:
        newHead = Offset(head.dx - 1, head.dy);
        break;
      case Direction.right:
        newHead = Offset(head.dx + 1, head.dy);
        break;
    }
    //insert new head
    snake.body.insert(0, newHead);
    // Check if food is eaten
    if (newHead == food.position) {
      spawnFood(); // grow snake
    } else {
      snake.body.removeLast(); // just move forward
    }
  }
}
