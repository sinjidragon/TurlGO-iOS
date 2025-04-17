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

class _PressableButtonState extends State<PressableButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.95), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0).whenComplete(() {
      widget.onTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
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
