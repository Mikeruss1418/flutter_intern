extension StringExtension on String {
  String toolongtrim() {
    return length > 15 ? '${substring(0, 15)}...' : this;
  }
}
