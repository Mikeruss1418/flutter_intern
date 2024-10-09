import 'dart:math';

void main() {
  print('${lengthOfLongestSubstring('abcccc')}');
}

int lengthOfLongestSubstring(String s) {
  int maxLength = 0;
  int left = 0;
  Set<String> charSet = {};

  for (int right = 0; right < s.length; right++) {
    while (charSet.contains(s[right])) {
      charSet.remove(s[left]);
      left++;
    }
    charSet.add(s[right]);
    maxLength = max(maxLength, right - left + 1);
  }

  return maxLength;
}
