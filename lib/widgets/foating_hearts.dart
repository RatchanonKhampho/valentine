import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../config/app_config.dart';

/// 💕 พื้นหลังหัวใจลอย (Enhanced Premium)
class FloatingHearts extends StatefulWidget {
  const FloatingHearts({super.key});

  @override
  State<FloatingHearts> createState() => _FloatingHeartsState();
}

class _FloatingHeartsState extends State<FloatingHearts>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Size screenSize;
  final List<HeartData> hearts = [];
  final random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    // สร้างหัวใจที่หลากหลายขึ้น
    for (int i = 0; i < AppConfig.heartCount; i++) {
      hearts.add(_createHeart(random.nextDouble()));
    }
  }

  HeartData _createHeart(double startY) {
    final heartEmojis = ['❤️', '💖', '💕', '💗', '💓', '💝', '💘', '💞'];

    return HeartData(
      x: random.nextDouble(),
      y: startY,
      size:
          AppConfig.heartMinSize +
          random.nextDouble() *
              (AppConfig.heartMaxSize - AppConfig.heartMinSize),
      speed: 0.08 + random.nextDouble() * 0.25,
      sway: random.nextDouble() * 2 * pi,
      swaySpeed: 0.5 + random.nextDouble() * 1.5,
      emoji: heartEmojis[random.nextInt(heartEmojis.length)],
      opacity: 0.1 + random.nextDouble() * 0.3,
      rotation: random.nextDouble() * 2 * pi,
      blur: random.nextBool(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Stack(
          children:
              hearts.map((heart) {
                // เคลื่อนที่ขึ้น
                heart.y -= heart.speed * 0.008;

                // Reset เมื่อออกจากหน้าจอ
                if (heart.y < -0.15) {
                  final index = hearts.indexOf(heart);
                  hearts[index] = _createHeart(1.15);
                }

                // คำนวณการแกว่ง
                final swayOffset =
                    sin(
                      (_controller.value * 2 * pi * heart.swaySpeed) +
                          heart.sway,
                    ) *
                    30;

                // คำนวณการหมุน
                final rotation =
                    heart.rotation +
                    (sin((_controller.value * 2 * pi) + heart.sway) * 0.3);

                return Positioned(
                  left: heart.x * screenSize.width + swayOffset,
                  top: heart.y * screenSize.height,
                  child: Opacity(
                    opacity:
                        heart.opacity *
                        (0.7 +
                            0.3 * sin(_controller.value * 2 * pi + heart.sway)),
                    child: Transform.rotate(
                      angle: rotation,
                      child:
                          heart.blur
                              ? ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                  sigmaX: 1.5,
                                  sigmaY: 1.5,
                                ),
                                child: _buildHeart(heart),
                              )
                              : _buildHeart(heart),
                    ),
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildHeart(HeartData heart) {
    return Text(
      heart.emoji,
      style: TextStyle(
        fontSize: heart.size,
        shadows: [Shadow(color: Colors.pink.withOpacity(0.4), blurRadius: 4)],
      ),
    );
  }
}

/// 💝 ข้อมูลหัวใจ (Enhanced)
class HeartData {
  double x;
  double y;
  final double size;
  final double speed;
  final double sway;
  final double swaySpeed;
  final String emoji;
  final double opacity;
  final double rotation;
  final bool blur;

  HeartData({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.sway,
    required this.swaySpeed,
    required this.emoji,
    required this.opacity,
    required this.rotation,
    required this.blur,
  });
}
