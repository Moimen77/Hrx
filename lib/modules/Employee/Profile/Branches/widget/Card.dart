import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final Widget child;
  const Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(.05),
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
