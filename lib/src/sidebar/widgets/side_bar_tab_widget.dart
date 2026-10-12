import 'package:flutter/material.dart';

class SideBarTabWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final IconData icon;
  final bool isActive;
  final bool isHighlighted;
  const SideBarTabWidget({
    super.key,
    required this.text,
    required this.onClick,
    required this.icon,
    this.isActive = false,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isHighlighted
            ? ColorScheme.of(context).secondary
            : isActive
            ? ColorScheme.of(context).surface
            : ColorScheme.of(context).onPrimary,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(icon),
          Expanded(child: Container()),
          Text(text),
          Expanded(flex: 4, child: Container()),
        ],
      ),
    );
  }
}
