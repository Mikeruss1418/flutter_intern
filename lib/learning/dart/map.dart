void main() {
  //max number
  // Map<int, int> numbers = {
  //   1: 10,
  //   2: 20,
  //   3: 30,
  //   4: 40,
  //   5: 50,
  // };
  // var maxvalue = numbers.values.reduce(
  //   (value, element) => value > element ? value : element,
  // );
  // print('Maxvalue $maxvalue');
  // //for least value
  // var minvalue = numbers.values.reduce(
  //   (value, element) => value < element ? value : element,
  // );
  // print('MinValue $minvalue');
  // //for average
  // var sum = numbers.values.reduce(
  //   (value, element) => value + element,
  // );
  // print('Sum:$sum');
  // print('Avgvalue: ${sum / numbers.values.length}');

  //case sensitive
  // Map<int, String> strings = <int, String>{1: "hello", 2: 'world', 3: 'Dart'};

  // var uppercase = strings.forEach(
  //   (key, value) => print('${value.toUpperCase()}'),
  // );
  // var firstuppecase = strings.forEach(
  //   (key, value) => print('${value.substring(0,1).toUpperCase()}${value.substring(1)}'),
  // );

  //longest string
  // Map<int, String> strings = <int, String>{1: "hello", 2: 'world', 3: 'Dart'};
  // var longest = strings.values.reduce(
  //   (value, element) => value.length > element.length ? value : element,
  // );
  // print(longest);

  //most frequent string
  var strings = {
    'a': 'hello',
    'b': 'world',
    'c': 'hello',
    'd': 'dart',
    'e': 'hello',
  };

  /// This code snippet is creating a frequency map to count the occurrences of each unique string in the
  /// `strings` map. Here's a breakdown of what it does:
  Map<String, int> repeated = <String,
      int>{}; //to indicate that this string has been called this many times
  strings.values.forEach(
    (value) {
      repeated[value] = (repeated[value] ?? 0) + 1;
      print('${repeated['hello']}');//getting value from key
    },
  );
  var mostFrequentString =
      repeated.entries.reduce((a, b) => a.value > b.value ? a : b).key;

  print(mostFrequentString); //
}
/**
 Here's an example of how this works:

Suppose the strings map has the values ["apple", "banana", "apple", "orange"].
The first time we encounter "apple", repeated["apple"] is null, so we set it to 1.
The second time we encounter "apple", repeated["apple"] is already 1, so we increment it to 2.
We do the same for "banana" and "orange".
 */
