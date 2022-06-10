import 'package:flutter/material.dart';
import 'package:ralga/utils/colors.dart';


class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = overlayWhiteColor,
    this.iconColor = whiteColor,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor),
      child: Stack(
        children: [
          Positioned(
            bottom: 9,
            left: 9,
            child: Icon(
              icon,
              color: iconColor,
              size: size / 2,
            ),
          ),
          
        ],
      ),
    );
  }
}