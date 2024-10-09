void main() {
  // lengthOfLastWord(' Hello World ');
  print("${lengthOfLastWord("   fly me   to   the moon  ")}");
}

int lengthOfLastWord(String s) {
  List<String> item = s.trim().split(' ');
  return item.last.length;
}
/**
 * List<String> words = s.split(RegExp(r'\s+')).map((word) => word.trim()).toList();
 */

