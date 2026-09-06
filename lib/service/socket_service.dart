import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tic_tac_toe_app/core/constants/api_constants.dart';
import 'package:tic_tac_toe_app/core/constants/socket_events.dart';

class SocketService {
  // Private Constructor
  SocketService._internal();

  // Single static instance of the class
  static final SocketService _instance = SocketService._internal();

  // Factory Constructor helps to return the same intance every time
  factory SocketService() {
    return _instance;
  }

  late IO.Socket socket;

  Function(dynamic)? onRoomUpdated;

  Function(dynamic)? onGameUpdated;

  Function(dynamic)? onGameDestroyed;

  Future<void> initializeSocket(String token) async {
    // CREATE Socket
    socket = IO.io(
      ApiConstants.baseUri,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setAuth({"token": token})
          .build(),
    );

    // REGISTERED listners before socket connects
    socket.on(SocketEvents.roomUpdated, (data) {
      if (onRoomUpdated != null) {
        onRoomUpdated!(data);
      }
    });

    socket.on(SocketEvents.gameUpdated, (data) {
      if (onGameUpdated != null) {
        onGameUpdated!(data);
      }
    });

    socket.on(SocketEvents.gameDestroyed, (data){

      if(onGameDestroyed != null){
        onGameDestroyed!(data['message']);
      }
      socket.emit(SocketEvents.leaveRoom);
    });

    socket.onConnect((_) {
      print('Socket Connected!');
      print(socket.id);
    });

    socket.onDisconnect((_) {
      print('Socket Disconnected');
    });

    socket.onConnectError((error) {
      print(error);
    });

    // Connects the socket to server
    socket.connect();
  }

  void makeMove(String roomCode, int index) {
    socket.emit(SocketEvents.makeMove, {"roomCode": roomCode, "index": index});
  }

  void joinRoom(String roomCode) {
    socket.emit('joinRoom', {"roomCode": roomCode});
  }

  void playerLeave(){
      socket.emit(SocketEvents.leaveRoom);
  }

  void dispose() {}
}
