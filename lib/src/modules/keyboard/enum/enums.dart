enum DeviceType { mobile, tablet, desktop }

enum Type { number, operator, backspace, equal }

enum CalcKey {
  backSpace(Type.backspace, '⌫', '↩', false),
  one(Type.number, '1', '1', false),
  four(Type.number, '4', '4', false, ['g', 'h', 'i']),
  seven(Type.number, '7', '7', false, ['p', 'q', 'r', 's']),
  zero(Type.number, '0', '0', false),
  //
  division(Type.operator, '÷', '/', true),
  two(Type.number, '2', '2', false, ['a', 'b', 'c']),
  five(Type.number, '5', '5', false, ['j', 'k', 'l']),
  eight(Type.number, '8', '8', false, ['t', 'u', 'v']),
  doubleZero(Type.number, '00', '00', false),
  //
  multiply(Type.operator, '×', '*', true),
  three(Type.number, '3', '3', false, ['d', 'e', 'f']),
  six(Type.number, '6', '6', false, ['m', 'n', 'o']),
  nine(Type.number, '9', '9', false, ['w', 'x', 'y', 'z']),
  trippleZero(Type.number, '000', '000', false),
  //
  substract(Type.operator, '−', '-', true),
  add(Type.operator, '+', '+', true),
  equalKey(Type.equal, '=', '=', false),
  point(Type.operator, '•', '.', false);

  final List? characters;
  final bool isOperator;
  final Type keyType;
  final String char;
  final String val;

  const CalcKey(this.keyType, this.char, this.val, this.isOperator,
      [this.characters]);
}
