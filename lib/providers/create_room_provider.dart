import 'package:flutter/material.dart';

class CreateRoomProvider extends ChangeNotifier{
  
    final FocusNode roomIdFocus = FocusNode();

    final TextEditingController roomIdController = TextEditingController();

  @override
  void dispose() {
    roomIdFocus.dispose();
    roomIdController.dispose();
    super.dispose();
  }
}