void main() {
  Map<String, int> original = {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5};
  Map<String, int> filtered = <String, int>{};
  Map<String, int> multiple = <String, int>{};
  Map<String, int> isprime = <String, int>{};
  int threshold = 3;
  int divider = 2;

  original.forEach(
    (key, value) {
      if (value > threshold) {
        filtered[key] = value;
      }
    },
  );
  print(filtered);

  original.forEach(
    (key, value) {
      if (value % divider == 0) {
        multiple[key] = value;
      }
    },
  );
  print(multiple);

  original.forEach(
    (key, value) {
      if (value > 1) {
        if (value % value == 0 && value % 1 == 0 && !value.isEven ) {
          isprime[key] = value;
        }
      }
    },
  );
  print(isprime);
}
