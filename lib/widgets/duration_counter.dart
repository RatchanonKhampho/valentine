// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valentine_day/config/app_color.dart';
import 'package:valentine_day/config/app_text.dart';


/// ⏰ Widget แสดงระยะเวลาแบบแยกปี เดือน วัน
class DurationCounter extends StatefulWidget {
  final Map<String, int> duration;
  final String emoji;
  final String label;
  final int delay; // milliseconds

  const DurationCounter({
    super.key,
    required this.duration,
    required this.emoji,
    required this.label,
    this.delay = 0,
  });

  @override
  State<DurationCounter> createState() => _DurationCounterState();
}

class _DurationCounterState extends State<DurationCounter>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _yearsController;
  late AnimationController _monthsController;
  late AnimationController _daysController;

  late Animation<double> _fadeAnimation;
  late Animation<int> _yearsAnimation;
  late Animation<int> _monthsAnimation;
  late Animation<int> _daysAnimation;

  @override
  void initState() {
    super.initState();

    final years = widget.duration['years'] ?? 0;
    final months = widget.duration['months'] ?? 0;
    final days = widget.duration['days'] ?? 0;

    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    // Counter animations
    _yearsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _monthsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _daysController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _yearsAnimation = IntTween(
      begin: 0,
      end: years,
    ).animate(CurvedAnimation(parent: _yearsController, curve: Curves.easeOut));
    _monthsAnimation = IntTween(begin: 0, end: months).animate(
      CurvedAnimation(parent: _monthsController, curve: Curves.easeOut),
    );
    _daysAnimation = IntTween(
      begin: 0,
      end: days,
    ).animate(CurvedAnimation(parent: _daysController, curve: Curves.easeOut));

    // Start animations with delays
    Future.delayed(Duration(milliseconds: widget.delay), () {
      _fadeController.forward();
      _yearsController.forward();
      Future.delayed(const Duration(milliseconds: 200), () {
        _monthsController.forward();
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        _daysController.forward();
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _yearsController.dispose();
    _monthsController.dispose();
    _daysController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Emoji
            Text(widget.emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 12),

            // Label
            Text(
              widget.label,
              style: GoogleFonts.sarabun(
                fontSize: 20,
                color: AppColors.textGray,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Duration counters
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Years (only show if >= 1)
                if ((widget.duration['years'] ?? 0) > 0) ...[
                  _buildTimeUnit(
                    animation: _yearsAnimation,
                    unit: AppTexts.yearUnit,
                    color: AppColors.yearColor,
                  ),
                  const SizedBox(width: 16),
                ],

                // Months
                _buildTimeUnit(
                  animation: _monthsAnimation,
                  unit: AppTexts.monthUnit,
                  color: AppColors.monthColor,
                ),
                const SizedBox(width: 16),

                // Days
                _buildTimeUnit(
                  animation: _daysAnimation,
                  unit: AppTexts.dayUnit,
                  color: AppColors.dayColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeUnit({
    required Animation<int> animation,
    required String unit,
    required Color color,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.3), width: 2),
              ),
              child: Text(
                '${animation.value}',
                style: GoogleFonts.sarabun(
                  fontSize: 36,
                  color: color,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              unit,
              style: GoogleFonts.sarabun(
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }
}
