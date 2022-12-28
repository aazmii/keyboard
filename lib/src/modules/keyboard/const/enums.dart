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
  add(keyType: Type.operator),
  substract(keyType: Type.operator),
  division(keyType: Type.operator),
  multiply(keyType: Type.operator);

  final List? charactes;
  final Type keyType;
  const CalcKey({
    required this.keyType,
    this.charactes,
  });
}

enum Type { number, operator }
