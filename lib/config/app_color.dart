import 'package:flutter/material.dart';

/// 🎨 สีธีมทั้งหมดของแอป (Pastel / Soft Version)
class AppColors {
  AppColors._();

  // 🌸 สีหลัก - Soft Pink
  static const Color primaryLight = Color(0xFFFFF2F7);
  static const Color primaryMedium = Color(0xFFFFD6E8);
  static const Color primaryDark = Color(0xFFFFAFCB);

  // 💕 สีเน้น - Pastel Rose
  static const Color accentPink = Color(0xFFFF9DBB);
  static const Color accentRose = Color(0xFFFFB7C9);
  static const Color accentCoral = Color(0xFFFFAEB8);

  // 🎀 Gradient สำหรับหน้า Intro
  static const List<Color> introGradient = [
    Color(0xFFFFDCE6),
    Color(0xFFFFF4F8),
  ];

  // 📅 Gradient สำหรับหน้านับวัน
  static const List<Color> daysGradient = [
    Color(0xFFFFE3EC),
    Color(0xFFFFFBFD),
  ];

  // 💌 Gradient สำหรับหน้าจดหมาย
  static const List<Color> letterGradient = [
    Color(0xFFFFF7FA),
    Color(0xFFFFFFFF),
  ];

  // 🎁 Gradient สำหรับหน้าเซอร์ไพรส์
  static const List<Color> surpriseGradient = [
    Color(0xFFFFC1D6),
    Color(0xFFFFE1EC),
  ];

  // ⚪ สีพื้นฐาน
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color textDark = Color(0xFF374151);
  static const Color textGray = Color(0xFF9CA3AF);

  // 💫 สีสำหรับการนับวัน
  static const Color yearColor = Color(0xFFFF8FB8);
  static const Color monthColor = Color(0xFFFFA3C4);
  static const Color dayColor = Color(0xFFFFBDD6);

  // 🌟 สีเงา (เบามาก ดูฟุ้ง)
  static Color shadowLight = Colors.pink.withOpacity(0.06);
  static Color shadowMedium = Colors.pink.withOpacity(0.1);
  static Color shadowDark = Colors.pink.withOpacity(0.15);

  // ✨ สีพื้นหลังการ์ด
  static Color cardBackground = Colors.white.withOpacity(0.9);
  static Color cardBackgroundDark = Colors.white.withOpacity(0.8);
}
