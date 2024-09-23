class Tab {
  final int index;
  final String title;

  Tab({required this.index, required this.title})
      : assert(index >= 0, 'index should not be negative'),
        assert(title != null, 'title cannot be null');
}
