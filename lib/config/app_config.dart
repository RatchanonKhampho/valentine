/// ⚙️ การตั้งค่าหลักของแอป
/// แก้ไขวันที่และค่าต่างๆ ได้ที่นี่
class AppConfig {
  AppConfig._(); // Private constructor

  // 📅 วันที่เริ่มคุยกัน (ปี, เดือน, วัน)
  static final DateTime startChatDate = DateTime(2025, 7, 3); // 3 กรกฎาคม 2025

  // 💕 วันที่เริ่มเป็นแฟน
  static final DateTime startLoveDate = DateTime(2026, 1, 3); // 3 มกราคม 2026

  // ⌨️ ความเร็วในการพิมพ์ข้อความ (มิลลิวินาที
  static const int typingSpeed = 40;

  // 🎯 ความเร็ว Animation (มิลลิวินาที)
  static const int fadeInDuration = 1200;
  static const int counterDuration = 1500;
  static const int buttonDelay = 800;

  // 💫 จำนวนหัวใจที่ลอย
  static const int heartCount = 15;

  // 📐 ขนาดหัวใจ
  static const double heartMinSize = 20.0;
  static const double heartMaxSize = 35.0;
}
