import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe_app/providers/login_provider.dart';
import 'package:tic_tac_toe_app/screens/login/login_screen.dart';
import 'package:tic_tac_toe_app/screens/menu/menu_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {

  


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<LoginProvider>().checkAuth(), 
      builder: (context, snapshot) {
        if (snapshot.data == true){
          return MenuScreen();
        } else{
          return LoginScreen();
        }
      },
      );
  }
}