// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:valentine_day/widgets/foating_hearts.dart';

import 'days_page.dart';

/// 💌 Intro Page – Fixed & Visible Version
class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openLetter() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => const DaysPage(),
        transitionsBuilder:
            (_, animation, __, child) =>
                FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SizedBox.expand(
            // 🔑 สำคัญมาก
            child: Stack(
              alignment: Alignment.center,
              children: [
                const FloatingHearts(),

                /// 🎈 Background Balloons (ขยับลงได้จริง)
                Positioned(
                  top: size.height * 0.1, // 👈 ปรับตรงนี้
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Lottie.asset(
                        "assets/images/lottie/Red Balloons.json",
                        width: isMobile ? size.width * 0.8 : 300,
                        height: isMobile ? size.width * 0.8 : 300,
                        fit: BoxFit.cover,
                        repeat: true,
                      ),
                    ),
                  ),
                ),

                /// 💌 Letter Card (Foreground)
                AnimatedScale(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  scale: _isPressed ? 0.95 : 1.0,
                  child: Container(
                    width: isMobile ? size.width * 0.75 : 320,
                    height: isMobile ? size.width * 0.75 : 320,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        /// 💗 Soft heart
                        Positioned(
                          top: 12,
                          right: 16,

                          child: Icon(
                            Icons.favorite,
                            size: 72,
                            color: Colors.pink.withOpacity(0.12),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          right: 16,
                          left: 16,
                          child: Lottie.asset(
                            "assets/images/lottie/Happy Valentine Day.json",
                            width: isMobile ? size.width * 0.4 : 120,
                            height: isMobile ? size.width * 0.4 : 120,
                            repeat: true,
                          ),
                        ),

                        /// Main content
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 60),
                              Lottie.asset(
                                "assets/images/lottie/Valentine date.json",
                                width: isMobile ? size.width * 0.4 : 220,
                                height: isMobile ? size.width * 0.4 : 220,
                                repeat: true,
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),

                        Positioned(
                          bottom: 28,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: GestureDetector(
                              onTapDown:
                                  (_) => setState(() => _isPressed = true),
                              onTapUp: (_) {
                                setState(() => _isPressed = false);
                                _openLetter();
                              },
                              onTapCancel:
                                  () => setState(() => _isPressed = false),
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 180),
                                curve: Curves.easeOut,
                                scale: _isPressed ? 0.95 : 1.0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.pink.shade50,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "💕 For You 💕",
                                    style: GoogleFonts.sarabun(
                                      fontSize: 16,
                                      color: Colors.pink.shade600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
