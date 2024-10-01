// void main() {
//   //onversion of dart list to map
//   List list = [
//     'Rojesh',
//     'Shrestha',
//     'Max',
//     'William',
//     'Russo',
//     'Frank',
//   ];
//   var map = {};
//   for (var item in list) {
//     //creates a new key-value pair with empty list
//     (map[item] = map[item] ?? []);
//     //add a value to the array
//     map[item].add(item);
//   }
//   print(map);
// }
void main() {
  // print('${Solution().isValid('{')}');
  print('${Mysoln().isValid('')}');
}

class Mysoln {
  bool isValid(String s) {
    String p1 = '[]';
    String p2 = '()';
    String p3 = '{}';
//
    while (s.isNotEmpty) {//here so 
      if (s.contains(p1)) {
        s=s.replaceAll(p1, '');
      } else if (s.contains(p2)) {
       s= s.replaceAll(p2, '');
      } else if (s.contains(p3)) {
       s= s.replaceAll(p3, '');
      } else {
        return false;
      }
    }
    return true;
  }
}

class Solution {
  bool isValid(String s) {
    String before = s;
    s = s.replaceAll("{}", "");
    s = s.replaceAll("[]", "");
    s = s.replaceAll("()", "");
    if (before != s) {
      return isValid(s);
    }
    if (s == "") return true;
    return false;
  }
}
