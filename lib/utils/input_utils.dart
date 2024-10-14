import 'dart:io';

class InputUtils {
  
  String capitalizeWord(String word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  int? getValidIntPrice(String prompt) {
    while (true) {
      stdout.writeln(prompt);
      String input = stdin.readLineSync()?.trim() ?? "";

      if (input.isEmpty) {
        stdout.writeln("Du måste ange ett värde.");
        continue;
      }

      try {
        int value = int.parse(input);
        if (value < 0) {
          stdout.writeln("Priset kan inte vara negativt. Försök igen.");
          continue;
        }
        return value;
      } on FormatException {
        stdout.writeln("Ogiltigt värde. Ange ett heltal.");
      }
    }
  }
}
