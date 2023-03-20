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
  backSpace('⌫', '↩'),
  one('1', '1'),
  four('4', '4', ['g', 'h', 'i']),
  seven('7', '7', ['p', 'q', 'r', 's']),
  zero('0', '0'),
  //
  division('÷', '/'),
  two('2', '2', ['a', 'b', 'c']),
  five('5', '5', ['j', 'k', 'l']),
  eight('8', '8', ['t', 'u', 'v']),
  doubleZero('00', '00'),
  //
  multiply('×', '*'),
  three('3', '3', ['d', 'e', 'f']),
  six('6', '6', ['m', 'n', 'o']),
  nine('9', '9', ['w', 'x', 'y', 'z']),
  trippleZero('000', '000'),
  //
  substract('−', '-'),
  addition('+', '+'),
  equalKey('=', '='),
  point('.', '.');

  final List? characters;
  final String char;
  final String val;

  const CalcKey(this.char, this.val, [this.characters]);
}

CalcKey? getCalcKeyByVal(String val){
  for (var item in CalcKey.values) {
    if (item.val == val) {
      return item;
    }
  }
  return null;
}
