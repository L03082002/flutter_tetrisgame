
  //grid dimensions
  import 'package:flutter/material.dart';

  int rowLength = 10;
  int collLength = 15;

enum Direction{
  left,
  right,
  down,
}


enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
  
  /*
    o
    o       L
    o o

      o 
      o     J
    o o

    o
    o
    o       I
    o

    o o
    o o     O

      o o
    o o     S

    o o
      o o   Z
    
    o
    o o     T
    o

   */
}

  const Map<Tetromino, Color> tetrominoColors = {
    Tetromino.L: Color(0xFFFFA500),
    Tetromino.J: Color(0xFF3A13A5),
    Tetromino.I: Color(0xFFDB22A1),
    Tetromino.O: Color(0xECE8E86D),
    Tetromino.S: Color(0xFF00FF1E),
    Tetromino.Z: Color(0xFFD518DF),
    Tetromino.T: Color(0xFFFFA500),
  };