import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:valentine_day/config/app_color.dart';
import 'package:valentine_day/config/app_text.dart';
import 'package:valentine_day/widgets/foating_hearts.dart';

import '../config/app_config.dart';

/// 💌 หน้าจดหมายรัก
class LetterPage extends StatefulWidget {
  const LetterPage({super.key});

  @override
  State<LetterPage> createState() => _LetterPageState();
}

class _LetterPageState extends State<LetterPage>
    with SingleTickerProviderStateMixin {
  String currentText = '';
  int index = 0;
  bool showButton = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _fadeController.forward();
    _startTyping();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _startTyping() {
    Timer.periodic(Duration(milliseconds: AppConfig.typingSpeed), (timer) {
      if (index < AppTexts.letterMessage.length) {
        setState(() {
          currentText += AppTexts.letterMessage[index];
          index++;
        });
      } else {
        timer.cancel();
        Future.delayed(Duration(milliseconds: AppConfig.buttonDelay), () {
          if (mounted) {
            setState(() {
              showButton = true;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.letterGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Stack(
              children: [
                const FloatingHearts(),
                Positioned(
                  top: 5,
                  child: Lottie.asset(
                    "assets/images/lottie/love hearts.json",
                    width: isMobile ? size.width * 1.2 : 220,
                    height: isMobile ? size.width * 0.55 : 220,
                    repeat: true,
                  ),
                ),

                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 40,
                      vertical: 32,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? size.width : 600,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Letter Icon
                          Icon(
                            Icons.favorite,
                            size: isMobile ? 50 : 70,
                            color: Colors.white.withOpacity(0.9),
                          ),

                          SizedBox(height: isMobile ? 20 : 28),

                          /// Letter Card
                          Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxHeight: size.height * 0.6,
                            ),
                            padding: EdgeInsets.all(isMobile ? 24 : 32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /// Decorative hearts
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        size: 14,
                                        color: Colors.pink.shade300,
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.favorite,
                                        size: 18,
                                        color: Colors.pink.shade400,
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.favorite,
                                        size: 14,
                                        color: Colors.pink.shade300,
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: isMobile ? 16 : 20),

                                  /// Letter text with typing effect
                                  Text(
                                    currentText,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.sarabun(
                                      fontSize: isMobile ? 16 : 18,
                                      height: 1.8,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                  /// Cursor blink
                                  if (index < AppTexts.letterMessage.length)
                                    _buildCursor(isMobile),

                                  SizedBox(height: isMobile ? 16 : 20),

                                  /// Bottom decorative line
                                  Container(
                                    width: 50,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: Colors.pink.shade200,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: isMobile ? 32 : 48),
                        ],
                      ),
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

  Widget _buildCursor(bool isMobile) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      builder: (context, double opacity, child) {
        return Opacity(
          opacity: opacity > 0.5 ? 1.0 : 0.0,
          child: Text(
            '|',
            style: GoogleFonts.sarabun(
              fontSize: isMobile ? 16 : 18,
              color: Colors.pink.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
      onEnd: () {
        if (mounted && index < AppTexts.letterMessage.length) {
          setState(() {});
        }
      },
    );
  }
}
