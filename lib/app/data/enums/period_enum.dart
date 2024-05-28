enum PeriodEnum {
  day,
  month,
  year;

  String get adjective {
    switch (this) {
      case day:
        return "Daily";
      case month:
        return "Monthly";
      case year:
        return "Yearly";
    }
  }

  static List<PeriodEnum> all = [day, month, year];
}
