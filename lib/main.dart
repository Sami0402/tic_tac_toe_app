import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/providers/create_room_provider.dart';
import 'package:tic_tac_toe_app/providers/game_provider.dart';
import 'package:tic_tac_toe_app/providers/join_room_provider.dart';
import 'package:tic_tac_toe_app/providers/login_provider.dart';
import 'package:tic_tac_toe_app/providers/room_provider.dart';
import 'package:tic_tac_toe_app/providers/register_provider.dart';
import 'package:tic_tac_toe_app/routes/app_routes.dart';
import 'package:tic_tac_toe_app/utils/auth_gate.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => CreateRoomProvider()),
        ChangeNotifierProvider(create: (_) => JoinRoomProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.black.withValues(alpha: 0.8),
        ),
      ),
      home: const AuthGate(),
      routes: AppRoutes.routes,
    );
  }
}
