import 'package:flutter/material.dart';

class CustomItemButtonSheetMenu extends StatelessWidget {
  final Color backGround;
  final IconData icon;
  final String title;
  final Function() onTap;

  const CustomItemButtonSheetMenu({
    super.key,
    required this.backGround,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backGround,
            ),
            child: Icon(
              icon,
              size: 35,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          FittedBox(child: Text(title)),
        ],
      ),
    );
  }
}
