extension ListWithToggleExtension on List {
  void toggleElement(Object? element) {
    if (contains(element)) {
      remove(element);
    } else {
      add(element);
    }
  }
}