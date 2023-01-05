enum DeviceType { mobile, tablet, desktop }

enum CalcKey {
  one(keyType: Type.number, charactes: []),
  two(keyType: Type.number, charactes: ['a', 'b', 'c']),
  three(keyType: Type.number, charactes: ['d', 'e', 'f']),
  four(keyType: Type.number, charactes: ['g', 'h', 'i']),
  five(keyType: Type.number, charactes: ['j', 'k', 'l']),
  six(keyType: Type.number, charactes: ['m', 'n', 'o']),
  seven(keyType: Type.number, charactes: ['p', 'q', 'r', 's']),
  eight(keyType: Type.number, charactes: ['t', 'u', 'v']),
  nine(keyType: Type.number, charactes: ['w', 'x', 'y', 'z']),
  zero(keyType: Type.operator),
  point(keyType: Type.operator),
  add(keyType: Type.operator),
  substract(keyType: Type.operator),
  division(keyType: Type.operator),
  equalKey(keyType: Type.equal),
  backSpace(keyType: Type.backspace),
  multiply(keyType: Type.operator);

  String getChar(CalcKey key) {
    switch (key) {
      case CalcKey.one:
        return '1';
      case CalcKey.two:
        return '2';
      case CalcKey.three:
        return '3';
      case CalcKey.four:
        return '4';
      case CalcKey.five:
        return '5';
      case CalcKey.six:
        return '6';
      case CalcKey.seven:
        return '7';
      case CalcKey.eight:
        return '8';
      case CalcKey.nine:
        return '9';
      case CalcKey.zero:
        return '0';
      case CalcKey.point:
        return '.';
      case CalcKey.add:
        return '+';
      case CalcKey.substract:
        return '-';
      case CalcKey.division:
        return '/';
      case CalcKey.equalKey:
        return '=';
      case CalcKey.backSpace:
        return '↩';
      case CalcKey.multiply:
        return '*';
    }
  }

  final List? charactes;
  final Type keyType;

  const CalcKey({
    required this.keyType,
    this.charactes,
  });
}

enum Type { number, operator, backspace, equal }
