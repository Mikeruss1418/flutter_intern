void main() {
  print('${Solution().climbStairs(3)}');
}

class Solution {
  int climbStairs(int n) {
    int oneStare = 1, twoStare = 1;

    for (int i = 0; i < n - 1; i++) {
      int times = oneStare;
      oneStare = oneStare + twoStare;
      twoStare = times;
    }

    return oneStare;
  }
}
