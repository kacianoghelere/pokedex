class FailureResult<T extends Exception> {
  final StackTrace stackTrace;
  final T e;

  FailureResult({
    required this.e,
    required this.stackTrace,
  });

  @override
  String toString() {
    return '${e.toString()}\n$stackTrace';
  }
}