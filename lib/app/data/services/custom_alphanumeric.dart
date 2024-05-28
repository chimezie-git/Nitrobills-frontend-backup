class CustomAlphaNumeric {
  static const _alpha = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  static String _getNum(int val) {
    if (val < 9) {
      return val.toString();
    } else if (val < 35) {
      return _alpha[val - 10];
    } else {
      throw Exception("wrong value");
    }
  }

  static String getCode(int num) {
    int val = num;
    List<String> code = [];
    do {
      int rem = val % 35;
      val = val - rem;
      val = val ~/ 35;
      code.add(_getNum(rem));
    } while (val > 0);
    return code.join();
  }

  static String uniqueTimeCode() {
    int timeCode = DateTime.now().microsecondsSinceEpoch;
    return getCode(timeCode);
  }
}
