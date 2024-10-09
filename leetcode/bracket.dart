void main() {
  print('${Solution().isValid('[]')}');
}
//firstly store the oneside brackets into list for comparision
//after the chooding the side check for it's reciprocal value after that 
class Solution {
  bool isValid(String s) {
    Map<String, String> brackets = {
      '(': ')',
      '{': '}',
      '[': ']',
    };
    List stack = []; //add only the opening brackets

    for (String braces in s.split('')) {
      if (brackets.containsKey(braces)) {
        stack.add(braces); //on;y open brackets
      } else if (brackets.containsValue(braces)) {
        if (stack.isEmpty || brackets[stack.removeLast()] != braces) {
          return false;
        }
      }
    }
    return stack.isEmpty;
  }
}
