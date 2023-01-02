// List<String> history = [];

class History {
  static List<String> history = [];
  static String get asText {
    String singleString = ' ';
    for (String expression in history) {
      singleString += '$expression, ';
    }
    return singleString;
  }
}
