void main() {
  print('${Solution().searchInsert([
        0,
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
      ], 5)}');
}

class Solution {
  //binary search algorithm
  int searchInsert(List<int> nums, int target) {
    int left = 0; //left range
    int right = nums.length - 1; //right range

    while (right >= left) {
      int mid = left + (right - left) ~/ 2;

      if (nums[mid] == target) {
        return mid;
      } else if (nums[mid] > target) {
        right = mid - 1;
      } else {
        left = mid + 1;
      }
    }

    return left;
  }
}
