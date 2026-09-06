import 'package:flutter/material.dart';

class JoinRoomProvider extends ChangeNotifier{
    final FocusNode roomIdFocus = FocusNode();

    final TextEditingController roomIdController = TextEditingController();

    @override
  void dispose() {
    roomIdFocus.dispose();
    roomIdController.dispose();
    super.dispose();
  }
}