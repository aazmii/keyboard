RegExp agKeyboardReg = RegExp(r'^(?:[^*/]|[0-9+/\-*](?<=^[0-9+/\-*]))$');

bool checkValid(String? v) {
  if (v!.isEmpty) return false;
  if (v[0] == CalcKey.division.char || v[0] == CalcKey.multiply.char) {
    return false;
  }
  if (v[v.length - 1] == CalcKey.addition.char ||
      v[v.length - 1] == CalcKey.substract.char ||
      v[v.length - 1] == CalcKey.multiply.char ||
      v[v.length - 1] == CalcKey.division.char) {
    return false;
  }
  return true;
}

enum CalcKey {
  backSpace('⌫', '↩', false),
  one('1', '1', false),
  four('4', '4', false, ['g', 'h', 'i']),
  seven('7', '7', false, ['p', 'q', 'r', 's']),
  zero('0', '0', false),
  //
  division('÷', '/', true),
  two('2', '2', false, ['a', 'b', 'c']),
  five('5', '5', false, ['j', 'k', 'l']),
  eight('8', '8', false, ['t', 'u', 'v']),
  doubleZero('00', '00', false),
  //
  multiply('×', '*', true),
  three('3', '3', false, ['d', 'e', 'f']),
  six('6', '6', false, ['m', 'n', 'o']),
  nine('9', '9', false, ['w', 'x', 'y', 'z']),
  trippleZero('000', '000', false),
  //
  substract('−', '-', true),
  addition('+', '+', true),
  equalKey('=', '=', true),
  point('.', '.', false);

  final List? characters;
  final bool isOperator;
  final String char;
  final String val;

  const CalcKey(this.char, this.val, this.isOperator, [this.characters]);
}

CalcKey? getCalcKeyByVal(String val) {
  for (var item in CalcKey.values) {
    if (item.val == val || item.char == val) return item;
  }
  return null;
}

String convertToExp(String val) {
  String exp = '';
  for (var i = 0; i < val.length; i++) {
    String char = val[i];
    CalcKey? calcKey = getCalcKeyByVal(char);
    if (calcKey != null) {
      exp += calcKey.val;
    } else {
      exp += val;
    }
  }
  return exp;
}

String convertToShowText(String val) {
  String txt = '';
  for (var i = 0; i < val.length; i++) {
    String char = val[i];
    CalcKey? calcKey = getCalcKeyByVal(char);
    if (calcKey != null) {
      txt += calcKey.char;
    } else {
      txt += char;
    }
  }
  return txt;
}

const allowedChars = [
  '0',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '.',
  '+',
  '-',
  '*',
  '/',
];
