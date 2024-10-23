class FailureResult<T extends Exception> {
  final StackTrace stackTrace;
  final T error;

  FailureResult({
    required this.error,
    required this.stackTrace,
  });

  @override
  String toString() {
    return '${error.toString()}\n$stackTrace';
  }
}
