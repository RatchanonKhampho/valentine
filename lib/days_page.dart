import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valentine_day/config/app_color.dart';
import 'package:valentine_day/config/app_text.dart';
import 'package:valentine_day/letter_page.dart';
import 'package:valentine_day/widgets/date_calculator.dart';
import 'package:valentine_day/widgets/foating_hearts.dart';

import '../config/app_config.dart';

/// 📅 หน้านับวัน
class DaysPage extends StatefulWidget {
  const DaysPage({super.key});

  @override
  State<DaysPage> createState() => _DaysPageState();
}

class _DaysPageState extends State<DaysPage> with TickerProviderStateMixin {
  late Map<String, int> chatDuration;
  late Map<String, int> loveDuration;

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation1;
  late Animation<Offset> _slideAnimation2;

  @override
  void initState() {
    super.initState();
    chatDuration = DateCalculator.calculateDuration(AppConfig.startChatDate);
    loveDuration = DateCalculator.calculateDuration(AppConfig.startLoveDate);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _slideAnimation1 = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideAnimation2 = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.daysGradient,
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
                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 40,
                      vertical: 32,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? size.width : 500,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Header with hearts decoration
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.white.withOpacity(0.8),
                                    size: isMobile ? 20 : 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    "ความทรงจำของเรา",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.sarabun(
                                      fontSize: isMobile ? 28 : 32,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.white.withOpacity(0.8),
                                    size: isMobile ? 20 : 24,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 80,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: isMobile ? 40 : 56),

                          /// Chat duration card with slide animation
                          SlideTransition(
                            position: _slideAnimation1,
                            child: _buildDurationCard(
                              duration: chatDuration,
                              emoji: AppTexts.chatEmoji,
                              label: AppTexts.chatLabel,
                              gradientColors: [
                                Colors.pink.shade50,
                                Colors.pink.shade100,
                              ],
                              isMobile: isMobile,
                            ),
                          ),

                          SizedBox(height: isMobile ? 24 : 32),

                          /// Love duration card with slide animation
                          SlideTransition(
                            position: _slideAnimation2,
                            child: _buildDurationCard(
                              duration: loveDuration,
                              emoji: AppTexts.loveEmoji,
                              label: AppTexts.loveLabel,
                              gradientColors: [
                                Colors.red.shade50,
                                Colors.red.shade100,
                              ],
                              isMobile: isMobile,
                            ),
                          ),

                          SizedBox(height: isMobile ? 48 : 64),

                          /// Button with animation
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.elasticOut,
                            builder: (context, value, child) {
                              return Transform.scale(
                                scale: value,
                                child: child,
                              );
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (_, animation, __) =>
                                            const LetterPage(),
                                    transitionsBuilder: (
                                      _,
                                      animation,
                                      __,
                                      child,
                                    ) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(
                                      milliseconds: 500,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 44 : 52,
                                  vertical: isMobile ? 16 : 18,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.pink.shade400,
                                      Colors.pink.shade300,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.pink.shade200.withOpacity(
                                        0.5,
                                      ),
                                      blurRadius: 24,
                                      offset: const Offset(0, 10),
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.mail_outline_rounded,
                                      color: Colors.white,
                                      size: isMobile ? 20 : 22,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      AppTexts.daysButton,
                                      style: GoogleFonts.sarabun(
                                        fontSize: isMobile ? 18 : 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: isMobile ? 20 : 22,
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDurationCard({
    required Map<String, int> duration,
    required String emoji,
    required String label,
    required List<Color> gradientColors,
    required bool isMobile,
  }) {
    // สร้างรายการหน่วยเวลาที่มีค่ามากกว่า 0
    final List<Map<String, dynamic>> timeUnits = [];

    if (duration['years']! > 0) {
      timeUnits.add({'value': duration['years']!, 'unit': 'ปี'});
    }
    if (duration['months']! > 0) {
      timeUnits.add({'value': duration['months']!, 'unit': 'เดือน'});
    }
    if (duration['days']! > 0) {
      timeUnits.add({'value': duration['days']!, 'unit': 'วัน'});
    }

    // ถ้าไม่มีเลย (0 ทั้งหมด) ให้แสดง 0 วัน
    if (timeUnits.isEmpty) {
      timeUnits.add({'value': 0, 'unit': 'วัน'});
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 24 : 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.95)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: gradientColors.last.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Emoji & Label
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  emoji,
                  style: TextStyle(fontSize: isMobile ? 32 : 36),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.sarabun(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 20 : 24),

          /// Divider
          Container(
            width: 60,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColors),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          SizedBox(height: isMobile ? 20 : 24),

          /// Duration numbers - แสดงเฉพาะที่มีค่า
          Wrap(
            alignment: WrapAlignment.center,
            spacing: isMobile ? 16 : 20,
            runSpacing: isMobile ? 16 : 20,
            children:
                timeUnits.map((unit) {
                  return _buildTimeUnit(
                    unit['value'],
                    unit['unit'],
                    gradientColors,
                    isMobile,
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(
    int value,
    String unit,
    List<Color> gradientColors,
    bool isMobile,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (context, scale, child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 24,
          vertical: isMobile ? 12 : 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value.toString(),
              style: GoogleFonts.sarabun(
                fontSize: isMobile ? 32 : 36,
                fontWeight: FontWeight.w700,
                color: Colors.pink.shade600,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              unit,
              style: GoogleFonts.sarabun(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
