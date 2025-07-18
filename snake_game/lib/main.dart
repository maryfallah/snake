import 'package:flutter/material.dart';
import 'package:snake_game/playground.dart';

void main() => runApp(const SnakeGame());

class SnakeGame extends StatelessWidget {
  const SnakeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PlayGround(),
      debugShowCheckedModeBanner: false,
    );
  }
}
