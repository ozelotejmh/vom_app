import 'package:flutter/material.dart';

class VomIconButton extends StatelessWidget {
  final IconData icon;
  final String tip;
  final VoidCallback? onPressed;
  final double iconsize;
  final bool question;
  final Color primary;
  final Color? secondary;

  const VomIconButton({
    super.key,
    required this.icon,
    required this.tip,
    this.onPressed,
    required this.iconsize,
    required this.question,
    required this.primary,
    this.secondary,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
      tooltip: tip,
      onPressed: onPressed,
      iconSize: iconsize,
      color: question ? primary : secondary,
    );
  }
}

class VomButton extends StatelessWidget {
  final IconData icon;
  final String tip;
  final VoidCallback? onpressed;

  const VomButton(
      {super.key, required this.icon, required this.tip, this.onpressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 79, 8, 8),
      shape: const StadiumBorder(),
      onPressed: onpressed,
      tooltip: tip,
      child: Icon(icon, color: Colors.white),
    );
  }
}
