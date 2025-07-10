import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.backgroundColor = const Color(0xFF4CAF50), // primaryGreen by default
    this.textColor = Colors.white, // white text by default
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: textColor, size: 16),
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontFamily: 'Sora',
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
