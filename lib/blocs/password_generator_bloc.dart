import 'dart:math';

class PasswordGeneratorBloc {
  static final _random = new Random();

  static String generatePassword(length, _includeUppercase, _includeLowercase,
      _includeNumbers, _includeSpecialCharacters) {
    var charset = getCharacterSets(_includeUppercase, _includeLowercase,
        _includeNumbers, _includeSpecialCharacters);
    var password = '';

    for (int i = 0; i < charset.length; i++) {
      int randomCharIndex = 0 + _random.nextInt(charset[i].length - 0);
      password += charset[i][randomCharIndex];
    }
    for (int i = 0; i < length - charset.length; i++) {
      int randomCharSetIndex = 0 + _random.nextInt(charset.length - 0);
      int randomCharIndex =
          0 + _random.nextInt(charset[randomCharSetIndex].length - 0);
      password += charset[randomCharSetIndex][randomCharIndex];
    }

    return password;
  }

  static List<String> getCharacterSets(_includeUppercase, _includeLowercase,
      _includeNumbers, _includeSpecialCharacters) {
    List<String> characterSets = [];
    if (_includeUppercase) {
      characterSets.add('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
    }
    if (_includeLowercase) {
      characterSets.add('abcdefghijklmnopqrstuvwxyz');
    }
    if (_includeNumbers) {
      characterSets.add('0123456789');
    }
    if (_includeSpecialCharacters) {
      characterSets.add('!@#\$%^&*()_+-=[]{};:,./<>?');
    }
    return characterSets;
  }
}

final passwordGeneratorBloc = PasswordGeneratorBloc();
