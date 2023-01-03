// List<String> history = [];

class History {
  static List<String> histories = [];
  static String get asText {
    String singleString = '';
    for (String expression in histories) {
      singleString += expression;
    }

    return singleString;
  }
}
