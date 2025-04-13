import 'package:flutter/material.dart';

class PressableButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  const PressableButton({
    super.key,
    required this.onTap,
    required this.child,
    this.width = 280,
    this.height = 70,
    this.color = const Color(0xFFEF798A),
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
  });

  @override
  State<PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<PressableButton> {
  bool _isPressed = false;

  void _handleTap() {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 80),
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: widget.borderRadius,
          ),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}
