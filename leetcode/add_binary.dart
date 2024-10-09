void main() {
  print(addBinary('11', '1'));
}

/**
 * To parse binary numbers or other large integers,
 *  convert the string representation
 *  to a BigInt using BigInt.parse('binaryString', radix: 2)
 */
String addBinary(String a, String b) {
  /// `BigInt n1 = BigInt.parse(a, radix: 2);` is parsing the binary string `a` into a `BigInt` number.
  /// The `radix: 2` parameter specifies that the string `a` is in base 2 (binary) format. This line of
  /// code converts the binary string `a` into a `BigInt` number `n1` for further arithmetic operations.
  BigInt n1 = BigInt.parse(a, radix: 2);
  BigInt n2 = BigInt.parse(b, radix: 2);
  BigInt sum = n1 + n2;
  return sum.toRadixString(2);
}
