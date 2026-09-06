import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';
import 'package:tic_tac_toe_app/utils/app_typography.dart';

class CustomSolidButton extends StatelessWidget {
  const CustomSolidButton({
    super.key,
    this.text = '',
    this.onTap,
    this.textStyle,
    this.borderRadius,
    this.boxBorder,
    this.child,
    this.backgroundColor,
  });

  final Function()? onTap;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxBorder? boxBorder;
  final Widget? child;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Container(
        height: 63,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColor.blue,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          border: boxBorder,
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: AppColor.blue,
              offset: Offset(0, 0),
            ),
          ],
        ),

        child: Center(
          child: Text(
            text,
            style: textStyle == null
                ? AppTypographyPoppins.bodySmall.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.w600,
                  )
                : textStyle!,
          ),
        ),
      ),
    );
  }
}
