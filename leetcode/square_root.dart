import 'dart:math';

void main() {
  print('${mySqrt(5)}');
}

int mySqrt(int x) {
  double n1 = x.toDouble();
  return sqrt(n1).toInt().round();
}
