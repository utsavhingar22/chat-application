import 'package:flutter/material.dart';

enum AvatarColor { purple, green, blue }

class AvatarWidget extends StatelessWidget {
  final String initial;
  final double size;
  final Color? backgroundColor;
  final AvatarColor? colorType;

  const AvatarWidget({
    Key? key,
    required this.initial,
    this.size = 40,
    this.backgroundColor,
    this.colorType,
  }) : super(key: key);

  Color _getColor() {
    if (backgroundColor != null) return backgroundColor!;
    
    switch (colorType) {
      case AvatarColor.purple:
        return const Color(0xFF9C27B0); // Purple
      case AvatarColor.green:
        return const Color(0xFF4CAF50); // Green
      case AvatarColor.blue:
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getColor(),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

