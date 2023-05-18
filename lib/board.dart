import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game/piece.dart';
import 'package:tetris_game/pixel.dart';
import 'package:tetris_game/values.dart';

/*
  GAME BOARD
  This is a 2x2 grid with null reprensenting an empty space
  A non empty will have the color to represent the landed pieces

 */

//Create game board
List<List<Tetromino?>> gameBoard = List.generate(
  collLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  //current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

  // current score
  int currentScore = 0;

  // game over status
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    //start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  //Game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        //clears line
        clearLines();

        //check landing
        checkLanding();

        //check if game is over
        if (gameOver == true) {
          timer.cancel();
          showGameOverDialog();
        }

        //move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // show game over dialog
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Your Score is : $currentScore"),
        actions: [
          TextButton(
            onPressed: () {
              //reset the game
              resetGame();
              Navigator.pop(context);
            },
            child: Text("Play Again"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    //clear the game board
    gameBoard = List.generate(
      collLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    //new game
    gameOver = false;
    currentScore = 0;

    //create new piece
    createNewPiece();

    //start game
    startGame();
  }

  //Check for collision in a future position
  //Return true -> there is a collision
  //Return false -> there is no collision
  bool checkCollision(Direction direction) {
    //loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      //calculate the row and column of the current position
      //Ex: Position = 25 -> row = 2 col = 5
      //=> int row = (position/rowLenght).floor() <=> (25/10).floor() <=> (2,5).floor() = 2
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      //adjust the row and col based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      //check if the piece is out of bounds (either too low or our far too ther left or right)
      if (row >= collLength || col < 0 || col >= rowLength) {
        return true;
      }
    }
    //if no collisions are detected, return false
    return false;
  }

  void checkLanding() {
    //if going down is  accupied
    if (checkCollision(Direction.down)) {
      //mark position as accupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = (currentPiece.position[i] % rowLength);

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type; 
        }
      }

      //once landed, create the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    //create a random object to generate random tetrommino types
    Random rand = Random();
    //create a new random tetrommino type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    /*
    
    Since our game over condition is if there is a piece at the top level,
    you want to check if the game is over when you create a new piece,
    instead of checking every frame, because new pieces are allowed to go through the top level
    but if there is already a piece in the top level when the new piece is created,
    the game is over
    
     */

    if (isGameOver()) {
      gameOver = true;
    }
  }

//MOVE LEFT
  void moveLeft() {
    //make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

//MOVE RIGHT
  void moveRight() {
    //make sure the move is valid before moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  //clear line
  void clearLines() {
    //step 1: Loop through each row of the game board from bottom to top
    for (int row = collLength - 1; row >= 0; row--) {
      //step 2: Initialize a variable to track if the row full
      bool rowisFull = true;

      //step 3: Check if the row is full (all columns in the row are filled with pieces)
      for (int col = 0; col < rowLength; col++) {
        //if there's an empty column, set rowisFullto false and break for loop
        if (gameBoard[row][col] == null) {
          rowisFull = false;
          break;
        }
      }

      //step 4: if the row is full, clear the row and shift rows down
      if (rowisFull) {
        //step 5: move all rows above the cleared row down by one position
        for (int r = row; r > 0; r--) {
          // copy the above row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        //step 6: set the top row to empty
        gameBoard[0] = List.generate(row, (index) => null);

        //step 7: increase the score
        currentScore++;
      }
    }
  }

  //GAME OVER METHOD
  bool isGameOver() {
    //check if any column in the top row are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    //if the top row is empty, the game is not over
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //Game Grid
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * collLength,
              physics:
                  const NeverScrollableScrollPhysics(), //khong cho cuon xuong
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength),
              itemBuilder: (context, index) {
                //get row and col of each index
                int row = (index / rowLength).floor();
                int col = (index % rowLength);

                //current piece
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                    child: index,
                  );
                }

                //landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                      color: tetrominoColors[tetrominoType], child: '');
                }
                //blank pixel
                else {
                  return Pixel(
                    color: Colors.grey[900],
                    child: index,
                  );
                }
              },
            ),
          ),

          //SCORE
          Text(
            "Score: $currentScore",
            style: TextStyle(color: Colors.white),
          ),

          //Game Controls
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //left
                IconButton(
                  onPressed: moveLeft,
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),

                //rotate
                IconButton(
                  onPressed: rotatePiece,
                  icon: Icon(Icons.rotate_right),
                  color: Colors.white,
                ),

                //right
                IconButton(
                  onPressed: moveRight,
                  icon: Icon(Icons.arrow_forward_ios),
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
