
void main() {
  Solution solution = Solution();
  String haystack = 'saddlesad';
  String needle = 'sad';
  int index = solution.strStr(haystack, needle);
  print('Index of $needle in $haystack: $index');
}

class Solution {
  int strStr(String haystack, String needle) {
    int index = haystack.indexOf(needle);
    return index != -1 ? index : -1;
  }
}
