import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Color borderColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.borderColor,
    this.borderRadius = 25.0,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: borderColor),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        label,
        style: textStyle ??
            TextStyle(
              color: borderColor,
              fontFamily: 'Sora',
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
