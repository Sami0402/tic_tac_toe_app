import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';
import 'package:tic_tac_toe_app/providers/register_provider.dart';
import 'package:tic_tac_toe_app/utils/app_typography.dart';
import 'package:tic_tac_toe_app/utils/validator.dart';
import 'package:tic_tac_toe_app/widgets/custom_solid_button.dart';
import 'package:tic_tac_toe_app/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  void onTap() async {
    if (_formKey.currentState!.validate()) {
      final message = await context.read<RegisterProvider>().register();

      if (message == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Account Created Successfully!!!", style: AppTypographyPoppins.bodySmall),
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
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      // TITLE
                      Text(
                        'Register',
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

                      // Username
                      CustomTextFormField(
                        labelText: "Username",
                        focusNode: context
                            .read<RegisterProvider>()
                            .userNameFocusNode,
                        validator: Validator.username,
                        controller: context
                            .read<RegisterProvider>()
                            .usernameController,

                        prefixIcon: Icon(
                          Icons.person_pin_outlined,
                          color: AppColor.grey,
                        ),
                        hintText: 'Enter your username',
                      ),
                      SizedBox(height: 23),

                      // EMAIL
                      CustomTextFormField(
                        labelText: "Email",
                        focusNode: context
                            .read<RegisterProvider>()
                            .emailFocusNode,
                        validator: Validator.email,

                        controller: context
                            .read<RegisterProvider>()
                            .emailController,

                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: AppColor.grey,
                        ),
                        hintText: 'Enter your email',
                      ),
                      SizedBox(height: 23),

                      // PASSWORD
                      CustomTextFormField(
                        labelText: 'Password',
                        focusNode: context
                            .read<RegisterProvider>()
                            .passwordFocusNode,
                        validator: Validator.password,

                        controller: context
                            .read<RegisterProvider>()
                            .passwordController,

                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColor.grey,
                        ),
                        hintText: 'Enter your password',
                        obscureText: true,
                      ),
                      SizedBox(height: 23),

                      CustomTextFormField(
                        labelText: "Confirm Password",
                        focusNode: context
                            .read<RegisterProvider>()
                            .confirmPasswordFocusNode,
                        validator: (p0) => Validator.confirmPassword(
                          p0,
                          context
                              .read<RegisterProvider>()
                              .passwordController
                              .text,
                        ),

                        controller: context
                            .read<RegisterProvider>()
                            .confirmPasswordController,

                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColor.grey,
                        ),
                        hintText: 'Enter your confirm password',
                        obscureText: true,
                      ),

                      SizedBox(height: 40),

                      // LOGIN BUTTON
                      CustomSolidButton(text: 'Register', onTap: onTap),
                      SizedBox(height: 28),

                      // NAVIGATE TO REGISTER
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: AppTypographyPoppins.bodySmall.copyWith(
                            color: AppColor.white.withValues(alpha: 0.8),
                          ),
                          children: [
                            TextSpan(
                              text: "Login",
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
                                    Navigator.pushNamed(context, "login"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
