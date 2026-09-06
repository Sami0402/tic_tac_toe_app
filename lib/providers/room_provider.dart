import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/models/room_model.dart';
import 'package:tic_tac_toe_app/service/api_service.dart';
import 'package:tic_tac_toe_app/service/socket_service.dart';

class RoomProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  Room? currentRoom;
  String? message;
  bool showJoinLabel = false;
  String? gameResult;
  Function(String)? showDialogBox;
  bool didHostWin = false;
  bool didGuestWin = false;

  set setDidHostWin(bool value) => didHostWin = value;

  set setDidGuestWin(bool value) => didGuestWin = value;

  void whoWon() {
    if (currentRoom!.winner == currentRoom!.hostUsername) {
      didHostWin = true;
    } else {
      didGuestWin = true;
    }
  }

  void registerSocketListners() {
    void roomUpdateHandler(dynamic data) {
      currentRoom = Room.fromJson(data);
      notifyListeners();
    }

    void gameUpdateHandler(dynamic data) {
      currentRoom = Room.fromJson(data);
      if (currentRoom!.status == "finished") {
        gameResult = '${currentRoom!.winner} Wins!';
        whoWon();
      } else if (currentRoom!.status == "draw") {
        gameResult = 'Its Draw!';
      } else {
        gameResult = null;
      }
      notifyListeners();
    }

    void gameDestroyHandler(dynamic message) {
      if (showDialogBox != null) {
        showDialogBox!(message);
      }
      notifyListeners();
    }

    SocketService().onRoomUpdated = roomUpdateHandler;
    SocketService().onGameUpdated = gameUpdateHandler;
    SocketService().onGameDestroyed = gameDestroyHandler;
  }

  void unregisterSocketListners() {
    SocketService().onRoomUpdated = null;
    SocketService().onGameUpdated = null;
  }

  Future<bool> createRoom(String symbol) async {
    try {
      final result = await apiService.createRoom(symbol);
      final statusCode = result[0];
      final data = result[1];

      if (statusCode == 201) {
        currentRoom = Room.fromJson(data['room']);
        message = data['message'];
        registerSocketListners();
        return true;
      } else {
        currentRoom = Room.fromJson(data['room']);
        message = data['message'];
        registerSocketListners();

        return false;
      }
    } catch (e) {
      message = e.toString();

      return false;
    }
  }

  Future<bool> joinRoom(String roomCode) async {
    try {
      final result = await apiService.joinRoom(roomCode);
      final statusCode = result[0];
      final data = result[1];

      if (statusCode == 200) {
        currentRoom = Room.fromJson(data['room']);
        showJoinLabel = false;
        notifyListeners();
        message = data['message'];
        registerSocketListners();
        return true;
      } else if (statusCode == 409) {
        currentRoom = Room.fromJson(data['room']);
        showJoinLabel = true;
        notifyListeners();
        message = data['message'];
        registerSocketListners();
        return true;
      } else {
        showJoinLabel = false;
        message = data['message'];
        return false;
      }
    } catch (e) {
      message = e.toString();

      return false;
    }
  }
}
