import 'package:flutter/material.dart';
import 'package:valentine_day/config/app_color.dart';


/// 🔘 ปุ่มที่มี Animation
class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final List<Color>? gradientColors;
  final double? width;

  const AnimatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.gradientColors,
    this.width,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  bool isPressed = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => isPressed = true);
          _controller.forward();
        },
        onTapUp: (_) {
          setState(() => isPressed = false);
          _controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () {
          setState(() => isPressed = false);
          _controller.reverse();
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: widget.width,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    widget.gradientColors ??
                    [AppColors.accentPink, AppColors.accentRose],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: isHovered ? 20 : 15,
                  offset: Offset(0, isHovered ? 8 : 6),
                ),
              ],
            ),
            child: Center(child: widget.child),
          ),
        ),
      ),
    );
  }
}
