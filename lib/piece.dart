import 'package:flutter/material.dart';
import 'package:tetris_game/board.dart';
import 'package:tetris_game/values.dart';

class Piece {
  //type of tetis piece
  Tetromino type;

  Piece({
    required this.type,
  });

  //the piece is just a list of integer
  List<int> position = [];

  // color of tetris piece
  Color get color {
    return tetrominoColors[type] ??
        const Color(0xFFFFFFFF); //Defaut to white if no color is found
  }

  //generrate the integers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7, 
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  //move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  //rotate piece
  int rotateState = 1;
  void rotatePiece() {
    List<int> newPosition = [];

    //rotate the piece based on it's type
    switch (type) {
      case Tetromino.L:
        switch (rotateState) {
          case 0:
            /*
          o
          o       L
          o o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            /*
          o o
            o
            o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
        case Tetromino.I:
        switch (rotateState) {
          case 0:
            /*
          o
          o       L
          o o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            /*
          o o
            o
            o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
        case Tetromino.J:
        switch (rotateState) {
          case 0:
            /*
          o
          o       L
          o o
           */

            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            /*
          o o
            o
            o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
        case Tetromino.O:
        switch (rotateState) {
          case 0:
            /*
          o
          o       L
          o o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            /*
          o o
            o
            o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
        case Tetromino.S:
        switch (rotateState) {
          case 0:
            /*
          o
          o       L
          o o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            /*
          o o
            o
            o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
        case Tetromino.T:
        switch (rotateState) {
          case 0:
            /*
          o
          o       L
          o o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            /*
          o o
            o
            o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
        case Tetromino.Z:
        switch (rotateState) {
          case 0:
            /*
          o
          o       L
          o o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 1:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 2:
            /*
            o o o
            o
           */

            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;

          case 3:
            /*
          o o
            o
            o
           */

            //get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that this new position is a valid move before assigning it to the real position
            if (piecePositionIsValid(newPosition)) {
              //update position
              position = newPosition;
              //update state
              rotateState = (rotateState + 1) % 4;
            }
            break;
        }
        break;
      default:
    }
  }

  //check is valid position 
  bool positionIsValid(int position) {
    //get the row and column of position
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    //if the position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

    //otherwise position is valid so return true
    else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool fisrtColOccupie = false;
    bool lastColOccupie = false;

    for (int pos in piecePosition) {
      //return false if any position is already taken
      if (!positionIsValid(pos)) {
        return false;
      }

      //get the col of position
      int col = pos % rowLength;

      //check if the first of last column is occupie
      if (col == 0) {
        fisrtColOccupie = true;
      }

      if (col == rowLength - 1) {
        fisrtColOccupie = true;
      }
    }
    //if there is a piece in the first col and last col, is it going through the wall
    return !(fisrtColOccupie && lastColOccupie);
  }
}
