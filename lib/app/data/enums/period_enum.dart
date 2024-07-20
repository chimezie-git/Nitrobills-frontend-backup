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

  String toServerString() {
    switch (this) {
      case custom:
        return "c";
      case day:
        return "d";
      case month:
        return "m";
      case year:
        return "y";
    }
  }

  factory PeriodEnum.fromServerString(String val) {
    switch (val.toLowerCase()) {
      case 'c':
        return custom;
      case 'd':
        return day;
      case 'm':
        return month;
      case 'y':
        return year;
      default:
        throw Exception("Nitrobills invalid server data");
    }
  }
}
