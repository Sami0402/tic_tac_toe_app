import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/screens/create_room/create_room_screen.dart';
import 'package:tic_tac_toe_app/screens/game/game_screen.dart';
import 'package:tic_tac_toe_app/screens/join_room/join_room_screen.dart';
import 'package:tic_tac_toe_app/screens/login/login_screen.dart';
import 'package:tic_tac_toe_app/screens/menu/menu_screen.dart';
import 'package:tic_tac_toe_app/screens/register/register_screen.dart';

class AppRoutes {

  static Map<String, Widget Function(BuildContext)> get routes => { 
        "login":(context) => LoginScreen(),
        "register":(context) => RegisterScreen(),
        "menu":(context) => MenuScreen(),
        "create_room":(context) => CreateRoomScreen(),
        "join_room":(context) => JoinRoomScreen(),
        "game":(context) => GameScreen(),       
    };
  
}