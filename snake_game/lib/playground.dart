import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    snake = Snake();
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
                    final isSnake = snake.body.contains(
                      Offset(x.toDouble(), y.toDouble()),
                    );

                    var color = isSnake ? Colors.green : Colors.grey[800];
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
}
