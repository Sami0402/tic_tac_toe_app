import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';
import 'package:tic_tac_toe_app/providers/join_room_provider.dart';
import 'package:tic_tac_toe_app/providers/room_provider.dart';
import 'package:tic_tac_toe_app/service/socket_service.dart';
import 'package:tic_tac_toe_app/utils/app_typography.dart';
import 'package:tic_tac_toe_app/utils/validator.dart';
import 'package:tic_tac_toe_app/widgets/custom_solid_button.dart';
import 'package:tic_tac_toe_app/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final _formKey = GlobalKey<FormState>();

  // JOIN ROOM - onTap
  void joinRoomOnTap() async {
    if (_formKey.currentState!.validate()) {
      final roomCode = context.read<JoinRoomProvider>().roomIdController.text;
      final success = await context.read<RoomProvider>().joinRoom(roomCode);
      final message = context.read<RoomProvider>().message;
      final showJoinLabel = context.read<RoomProvider>().showJoinLabel;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!, style: AppTypographyPoppins.bodySmall),
          ),
          snackBarAnimationStyle: AnimationStyle(
            duration: Duration(milliseconds: 300),
          ),
        );
        SocketService().joinRoom(context.read<RoomProvider>().currentRoom!.roomCode!);
        Navigator.pushReplacementNamed(context, 'game');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!, style: AppTypographyPoppins.bodySmall),
            action: showJoinLabel ? SnackBarAction(
              label: 'Join',
              textColor: AppColor.blue,
              onPressed: () => Navigator.pushReplacementNamed(context, 'game'),
            ) : null,
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
                'Join Room',
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

              // GAME ID
              CustomTextFormField(
                labelText: "Game ID",
                controller: context.read<JoinRoomProvider>().roomIdController,
                validator: Validator.roomId,
                focusNode: context.read<JoinRoomProvider>().roomIdFocus,
                prefixIcon: Icon(Icons.gamepad_outlined, color: AppColor.grey),
                hintText: 'Enter Game ID',
              ),

              SizedBox(height: 40),

              // LOGIN BUTTON
              CustomSolidButton(text: 'Start', onTap: joinRoomOnTap),
              SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
