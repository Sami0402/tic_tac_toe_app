import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';
import 'package:tic_tac_toe_app/providers/create_room_provider.dart';
import 'package:tic_tac_toe_app/providers/room_provider.dart';
import 'package:tic_tac_toe_app/service/socket_service.dart';
import 'package:tic_tac_toe_app/utils/app_typography.dart';
import 'package:tic_tac_toe_app/widgets/custom_solid_button.dart';
import 'package:tic_tac_toe_app/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
 final _formKey = GlobalKey<FormState>();

  void start() {  
      Navigator.pushReplacementNamed(context, "game");
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
                'Create Room',
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
                labelText: "Your Game ID",
                initialValue: context.read<RoomProvider>().currentRoom!.roomCode,
                focusNode: context.read<CreateRoomProvider>().roomIdFocus,
                prefixIcon: Icon(Icons.keyboard_alt_outlined, color: AppColor.grey),
              ),

              SizedBox(height: 23),

              

              // LOGIN BUTTON
              CustomSolidButton(text: 'Start', onTap: start),
              SizedBox(height: 28),

             
            ],
          ),
        ),
      ),
    );
  }

}