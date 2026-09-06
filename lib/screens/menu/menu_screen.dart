import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';
import 'package:tic_tac_toe_app/providers/room_provider.dart';
import 'package:tic_tac_toe_app/service/socket_service.dart';
import 'package:tic_tac_toe_app/utils/app_typography.dart';
import 'package:tic_tac_toe_app/widgets/custom_solid_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    // CREATE ROOM - onTap
    void createRoomOnTap() async {
      final success = await context.read<RoomProvider>().createRoom('X');
      final message = context.read<RoomProvider>().message;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!, style: AppTypographyPoppins.bodySmall),
          ),
          snackBarAnimationStyle: AnimationStyle(
            duration: Duration(milliseconds: 300),
          ),
        );

        Navigator.pushReplacementNamed(context, 'create_room');
        SocketService().joinRoom(context.read<RoomProvider>().currentRoom!.roomCode!);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!, style: AppTypographyPoppins.bodySmall),
            action: SnackBarAction(
              label: 'Join',
              textColor: AppColor.blue,
              onPressed: () => Navigator.pushReplacementNamed(context, 'game'),
            ),
          ),
          snackBarAnimationStyle: AnimationStyle(
            duration: Duration(milliseconds: 300),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: AppColor.ebonyBlack,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              // MENU - TEXT
              Text(
                'Menu',
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
              SizedBox(height: 30),

              // OPTIONS
              CustomSolidButton(
                text: 'Create Room',
                backgroundColor: AppColor.blue,
                onTap: createRoomOnTap,
              ),
              SizedBox(height: 40),

              CustomSolidButton(
                text: 'Join Room',
                backgroundColor: AppColor.blue,
                onTap: () => Navigator.pushNamed(context, "join_room"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
