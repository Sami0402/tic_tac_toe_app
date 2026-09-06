import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';
import 'package:tic_tac_toe_app/providers/login_provider.dart';
import 'package:tic_tac_toe_app/utils/app_typography.dart';
import 'package:tic_tac_toe_app/utils/validator.dart';
import 'package:tic_tac_toe_app/widgets/custom_solid_button.dart';
import 'package:tic_tac_toe_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  void login() async {
    if (_formKey.currentState!.validate()) {
      final message = await context.read<LoginProvider>().login();

      if (message == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Welcome Back",
              style: AppTypographyPoppins.bodySmall,
            ),
          ),
          snackBarAnimationStyle: AnimationStyle(
            duration: Duration(milliseconds: 300),
          ),
        );
        Navigator.pushReplacementNamed(context, "menu");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message, style: AppTypographyPoppins.bodySmall),
          ),
          snackBarAnimationStyle: AnimationStyle(
            duration: Duration(milliseconds: 300),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.ebonyBlack,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: .center,
            children: [
              // TITLE
              Text(
                'Login',
                style: AppTypographyEvilEmpire.h3.copyWith(
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: AppColor.blue,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 23),

              // EMAIL
              CustomTextFormField(
                labelText: "Email",
                controller: context.read<LoginProvider>().emailController,
                validator: Validator.email,
                focusNode: context.read<LoginProvider>().emailFocusNode,
                prefixIcon: Icon(Icons.person_outline, color: AppColor.grey),
                hintText: 'Enter your email',
              ),

              SizedBox(height: 23),

              // PASSWORD
              CustomTextFormField(
                labelText: 'Password',
                controller: context.read<LoginProvider>().passwordController,
                validator: Validator.password,
                focusNode: context.read<LoginProvider>().passwordFocusNode,
                prefixIcon: Icon(Icons.lock_outline, color: AppColor.grey),
                hintText: 'Enter your password',
                obscureText: true,
              ),

              SizedBox(height: 40),

              // LOGIN BUTTON
              CustomSolidButton(text: 'Login', onTap: login),
              SizedBox(height: 28),

              // NAVIGATE TO REGISTER
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: AppTypographyPoppins.bodySmall.copyWith(
                    color: AppColor.white.withValues(alpha: 0.8),
                  ),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: AppTypographyPoppins.bodySmall.copyWith(
                        color: AppColor.blue,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: AppColor.blue,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            Navigator.pushNamed(context, "register"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
