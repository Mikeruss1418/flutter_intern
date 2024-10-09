void main() {
  print('${Solution().removeElement([
        0,
        0,
        1,
        1,
        2,
        2,
      ], 2)}');
}

class Solution {
  int removeElement(List<int> nums, int val) {
    nums.removeWhere(
      (element) => element == val,
    );
    return nums.length;
  }
}
