import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';
import 'package:tic_tac_toe_app/utils/app_typography.dart';

class GameTile extends StatefulWidget {
  const GameTile({
    super.key,
    required this.value,
    required this.index,
    required this.currentTurn,
    required this.valueChanged,
  });

  final String value;
  final int index;
  final String currentTurn;
  final ValueChanged<String> valueChanged;

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void didUpdateWidget(covariant GameTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value.isEmpty && widget.value.isNotEmpty) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 110),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.valueChanged(widget.value),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.grey, width: 1.0),
        ),
        child: ScaleTransition(
          scale: _animation,
          child: Center(
            child: Text(
              widget.value,
              style: AppTypographyPoppins.h3.copyWith(
                fontWeight: FontWeight.bold,
                shadows: [
                  widget.value == 'X'
                      ? Shadow(
                          blurRadius: 30.0,
                          color: AppColor.blue,
                          offset: Offset(0, 0),
                        )
                      : Shadow(
                          blurRadius: 30.0,
                          color: AppColor.darkRed,
                          offset: Offset(0, 0),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
