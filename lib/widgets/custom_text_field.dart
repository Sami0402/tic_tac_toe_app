import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/constants/app_color.dart';
import 'package:tic_tac_toe_app/utils/app_typography.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.fillColor,
    this.prefixIcon,
    this.hintText,
    this.borderWidth,
    this.disabledBorderColor,
    this.focusedBorderColor,
    this.obscureText,
    this.controller,
    this.validator,
    this.keyboardType,
    required this.focusNode,
    this.initialValue,
  });

  final String labelText;
  final String? initialValue;
  final FocusNode focusNode;
  final Color? fillColor;
  final Icon? prefixIcon;
  final String? hintText;
  final bool? obscureText;
  final double? borderWidth;
  final Color? disabledBorderColor;
  final Color? focusedBorderColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isFocused = false;
  bool isObsecure = true;

  void _handleFocusChange() {
    setState(() {
      isFocused = widget.focusNode.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.labelText,
            style: AppTypographyEvilEmpire.displaySmall.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: AppColor.ebonyBlack,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: AppColor.blue,
                      offset: Offset(0, 0),
                    ),
                  ]
                : [],
          ),
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            validator: widget.validator,
            focusNode: widget.focusNode,
            keyboardType: widget.keyboardType,
            obscureText: (widget.obscureText ?? false) ? isObsecure : false,
            style: AppTypographyPoppins.title,
            decoration: InputDecoration(
              filled: widget.fillColor == null ? false : true,
              fillColor: widget.fillColor,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: widget.prefixIcon,

              iconColor: Color(0xFF707783),
              suffixIcon: widget.obscureText != null
                  ? IconButton(
                      onPressed: () => setState(() {
                        isObsecure = !isObsecure;
                      }),

                      icon: isObsecure == true
                          ? Icon(Icons.visibility_off_outlined)
                          : Icon(Icons.visibility_outlined),
                    )
                  : null,

              hintText: widget.hintText,
              hintStyle: AppTypographyPoppins.title.copyWith(
                color: AppColor.grey,
              ),

              contentPadding: EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 16,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: widget.disabledBorderColor ?? AppColor.blue,
                  width: widget.borderWidth ?? 1.0,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: widget.disabledBorderColor ?? AppColor.blue,
                  width: widget.borderWidth ?? 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: widget.disabledBorderColor ?? AppColor.blue,
                  width: widget.borderWidth ?? 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: widget.focusedBorderColor ?? AppColor.blue,
                  width: widget.borderWidth ?? 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
