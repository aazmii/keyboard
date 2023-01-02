class Record {
  int inputTime;
  String equation;
  Record({
    required this.inputTime,
    required this.equation,
  });
  static List<Record> records = [];
  static String get asText {
    String singleString = '';

    records.sort((a, b) => a.inputTime.compareTo(b.inputTime));
    for (final rec in records) {
      singleString += '${rec.equation},';
    }
    return singleString;
  }
}
