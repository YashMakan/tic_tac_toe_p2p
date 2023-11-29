import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe_p2p/core/constants/enums.dart';
import 'package:tic_tac_toe_p2p/core/exceptions/exceptions.dart';

class GameState extends GetxController {
  RxList<Player?> fields =
      RxList([null, null, null, null, null, null, null, null, null]);

  void claimField(int field) {
    if (field < 0 || field > 8 || fields.elementAt(field) != null) {
      throw InvalidClaimException();
    }
    if (status != GameStatus.p1Turn && status != GameStatus.p2Turn) {
      throw InvalidClaimException();
    }
    final newFields = fields.toList();
    newFields[field] = status == GameStatus.p1Turn ? Player.p1 : Player.p2;

    fields.value = newFields;
  }

  GameStatus get status {
    if (_hasThreeInARow(Player.p1)) return GameStatus.p1Won;
    if (_hasThreeInARow(Player.p2)) return GameStatus.p2Won;

    final occupiedFields = fields.where((field) => field != null);

    if (occupiedFields.length == 9) return GameStatus.draw;

    final hasEvenAmountOfOccupiedFields = occupiedFields.length % 2 == 0;

    return hasEvenAmountOfOccupiedFields
        ? GameStatus.p1Turn
        : GameStatus.p2Turn;
  }

  String formattedStatus(Player player) {
    if (status == GameStatus.draw) {
      return 'DRAW';
    } else {
      bool isP1Player = player == Player.p1;
      if ((isP1Player && status == GameStatus.p1Won) ||
          !isP1Player && status == GameStatus.p2Won) {
        return 'YOU WON';
      }
      if ((isP1Player && status == GameStatus.p2Won) ||
          !isP1Player && status == GameStatus.p1Won) {
        return 'THEY WON';
      }

      if ((isP1Player && status == GameStatus.p1Turn) ||
          !isP1Player && status == GameStatus.p2Turn) {
        return 'YOUR TURN';
      }
      if ((isP1Player && status == GameStatus.p2Turn) ||
          !isP1Player && status == GameStatus.p1Turn) {
        return 'THEIR TURN';
      }
    }
    return '';
  }

  Color formattedStatusColor(Player player) {
    if (status == GameStatus.draw) {
      return Colors.white;
    } else {
      bool isP1Player = player == Player.p1;
      if ((isP1Player && status == GameStatus.p1Won) ||
          !isP1Player && status == GameStatus.p2Won) {
        return Colors.greenAccent;
      }
      if ((isP1Player && status == GameStatus.p2Won) ||
          !isP1Player && status == GameStatus.p1Won) {
        return Colors.redAccent;
      }
    }
    return Colors.white60;
  }

  bool _hasThreeInARow(Player player) {
    if (fields.elementAt(0) == player && fields.elementAt(1) == player && fields.elementAt(2) == player ||
        fields.elementAt(3) == player && fields.elementAt(4) == player && fields.elementAt(5) == player ||
        fields.elementAt(6) == player && fields.elementAt(7) == player && fields.elementAt(8) == player ||
        fields.elementAt(0) == player && fields.elementAt(3) == player && fields.elementAt(6) == player ||
        fields.elementAt(1) == player && fields.elementAt(4) == player && fields.elementAt(7) == player ||
        fields.elementAt(2) == player && fields.elementAt(5) == player && fields.elementAt(8) == player ||
        fields.elementAt(0) == player && fields.elementAt(4) == player && fields.elementAt(8) == player ||
        fields.elementAt(2) == player && fields.elementAt(4) == player && fields.elementAt(6) == player) {
      return true;
    }
    return false;
  }
}
