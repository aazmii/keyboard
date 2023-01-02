// List<String> history = [];

class History {
  static List<String> history = [];
  static String get singleLineHistory {
    String singleString = ' ';
    for (String expression in history) {
      singleString += expression;
    }
    return singleString;
  }
}
