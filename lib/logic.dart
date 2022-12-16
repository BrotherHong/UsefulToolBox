// Input Format Exception
class InputFormatException implements Exception {
  final String _cause;
  InputFormatException(this._cause);

  String get cause => _cause;
}

// NCKU ID verification
const List<int> idAlphaMap = [0, 1, 2, 3, 4, 4, -1, 6, 7, 8, 9, 0, -1, 2, -1, 3, 4, 5, 6, 7, 8, 9, -1, -1, -1, 2];

bool _validIdFormat(String id) {
  if (id.length != 9) {
    return false;
  }
  for (int i = 0; i < 9; i++) {
    int ch = id.codeUnits[i];
    if ('a'.codeUnits[0] <= ch && ch <= 'z'.codeUnits[0]) {
      if (i >= 2) {
        return false;
      }
      if (idAlphaMap[ch - 'a'.codeUnits[0]] == -1) {
        return false;
      }
    } else if ('0'.codeUnits[0] <= ch && ch <= '9'.codeUnits[0]) {
      if (i == 0) {
        return false;
      }
    } else {
      return false;
    }
  }
  return true;
}

bool idVerify(String id) {
  id = id.toLowerCase();
  if (!_validIdFormat(id)) {
    throw InputFormatException('學號格式錯誤');
  }
  int sum = 0;
  for (int i = 0;i < 9;i++) {
    int k = 9 - i;
    int ch = id.codeUnits[i];
    if ('a'.codeUnits[0] <= ch && ch <= 'z'.codeUnits[0]) {
      sum += idAlphaMap[ch - 'a'.codeUnits[0]] * k;
    } else {
      sum += (ch - '0'.codeUnits[0]) * k;
    }
  }
  return (sum % 10 == 0);
}

// Prime Number Check
bool isPrimeNumber(String numStr) {
  int num;
  try {
    num = int.parse(numStr);
  } on FormatException {
    throw InputFormatException('須為正整數且介於範圍內');
  }
  
  if (!(1 <= num && num <= 1000000000)) {
    throw InputFormatException('須為正整數且介於範圍內');
  }

  if (num == 1) return false;
  if (num == 2) return true;

  for (int i = 2; i*i <= num; i++) {
    if (num%i == 0) {
      return false;
    }
  }
  return true;
}

// Base Converter
String baseConvert(String src, String initBaseStr, String targetBaseStr) {
  int initBase = int.parse(initBaseStr);
  int targetBase = int.parse(targetBaseStr);
  if (!(2 <= initBase && initBase <= 36) || 
      !(2 <= targetBase && targetBase <= 36)) {
    throw InputFormatException('進制必須位於2~36');
  }
  int num;
  try {
    num = int.parse(src, radix: initBase);
  } catch (e) {
    throw InputFormatException('轉換數字有誤');
  }
  return num.toRadixString(targetBase);
}