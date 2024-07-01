enum PeriodEnum {
  custom,
  day,
  month,
  year;

  String get adjective {
    switch (this) {
      case custom:
        return "Custom";
      case day:
        return "Daily";
      case month:
        return "Monthly";
      case year:
        return "Yearly";
    }
  }

  static List<PeriodEnum> allPeriod = [day, month, year];
}
