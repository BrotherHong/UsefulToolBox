// Input Format Exception
class InputFormatException implements Exception {
  final String _cause;
  InputFormatException(this._cause);

  String get cause => _cause;
}
