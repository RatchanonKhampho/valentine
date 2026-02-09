class DateCalculator {
  static Map<String, int> calculateDuration(DateTime startDate) {
    final now = DateTime.now();

    int years = now.year - startDate.year;
    int months = now.month - startDate.month;
    int days = now.day - startDate.day;

    if (days < 0) {
      months--;

      // ใช้เดือนที่ถูกลดแล้ว ไม่ใช่ now.month ตรง ๆ
      final adjustedMonthDate = DateTime(
        now.year,
        now.month - 1,
        startDate.day,
      );

      final daysInPreviousMonth =
          DateTime(adjustedMonthDate.year, adjustedMonthDate.month + 1, 0).day;

      days += daysInPreviousMonth;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    return {
      'years': years < 0 ? 0 : years,
      'months': months < 0 ? 0 : months,
      'days': days < 0 ? 0 : days,
    };
  }
}
