import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/service/api_service.dart';


class RegisterProvider extends ChangeNotifier {
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ApiService apiService = ApiService();

  Future<String?> register() async {
    try {
      final message = await apiService.register(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      return message;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
