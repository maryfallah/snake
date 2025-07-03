import 'package:flutter/material.dart';

class Snake {
  List<Offset> body;

  Snake()
    : body = [const Offset(10, 20), const Offset(10, 21), const Offset(10, 22)];

  Offset get head => body.first;
}
