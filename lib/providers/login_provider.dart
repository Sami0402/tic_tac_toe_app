import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe_app/service/api_service.dart';
import 'package:tic_tac_toe_app/service/socket_service.dart';


class LoginProvider extends ChangeNotifier {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ApiService apiService = ApiService();

  Future<bool> checkAuth() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final token  =  prefs.getString('token');

    if(token == null) return false;

     // initialize SOCKET
    await SocketService().initializeSocket(token);

    return true;
  }

  Future<String?> login() async {
    try {
     final message = await apiService.login(emailController.text, passwordController.text);
      return message;
    } catch (e) {
      throw Exception(e);
    }
  }


  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
