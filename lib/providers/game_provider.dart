import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/models/room_model.dart';
import 'package:tic_tac_toe_app/service/socket_service.dart';

class GameProvider extends ChangeNotifier {
  void tileOnTap(int index, String value, Room room) {
    // If game is "finished" or "draw"
    if(room.status != "playing"){
      return;
    }
    SocketService().makeMove(room.roomCode!, index);
  }

  
}
