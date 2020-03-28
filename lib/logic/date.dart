class Date {
  int day;
  int month;
  int year;

  Date withDay(int day) {
    this.day = day;
    return this;
  }

  Date withMonth(int month) {
    this.month = month;
    return this;
  }

  Date withYear(int year) {
    this.year = year;
    return this;
  }

  String formatDate(bool withMonthName) {
    if (withMonthName) {
      return "$day. of ${monthNames[month]} $year";
    } else {
      return "$day.${month + 1}.$year";
    }
  }

  int weekDay() {
    int monthCode = monthCodes[month];
    int yearCode;
    if (year == null) {
      yearCode = 0;
    } else {
      if (isLeapYear(year) && month < 3) {
        yearCode = Date.yearCode(year % 100) - 1;
      } else {
        yearCode = Date.yearCode(year % 100);
      }
    }
    int centuryCode = Date.centuryCode(year ~/ 100);
    return (day + monthCode + yearCode + centuryCode) % 7;
  }

  static final List<int> monthCodes = [4, 0, 0, 3, 5, 1, 3, 6, 2, 4, 0, 2];
  static final List<String> monthNames = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];

  // ignore: missing_return
  static int centuryCode(int year) {
    switch (year % 4) {
      case 0:
        return 0;
      case 1:
        return 5;
      case 2:
        return 3;
      case 3:
        return 1;
    }
  }

  static int yearCode(int year) {
    return (year + year ~/ 4 + 2) % 7;
  }

  static int maxDayFromDate(int month, {int year = 0}) {
    if (month == 2) {
      return isLeapYear(year) ? 29 : 28;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30;
    } else {
      return 31;
    }
  }

  static bool isLeapYear(int year) {
    if (year % 400 == 0) {
      return true;
    } else if (year % 100 == 0) {
      return false;
    } else if (year % 4 == 0) {
      return true;
    } else {
      return false;
    }
  }
}