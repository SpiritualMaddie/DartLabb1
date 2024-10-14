
import 'dart:io';

import '../models/person.dart';
import '../repositories/person_repository.dart';
import '../utils/console_utils.dart';
import '../utils/input_utils.dart';

class PersonUi {
  static final PersonUi _instance = PersonUi._internal();
  PersonUi._internal();
  factory PersonUi() => _instance;

  var repoPerson = PersonRepository();
  var inputUtils = InputUtils();
  var consoleUtils = ConsoleUtils();

  void addNewPerson(){
    while (true) {
      consoleUtils.clearConsole();
      stdout.write("\nLägg till ny användare (Undvik å, ä, ö)\n");  
      stdout.writeln("Personnr:");
      String ssn = (stdin.readLineSync() ?? "").trim();
      if (ssn.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }

      stdout.writeln("Förnamn(utan å, ä, ö):");
      String firstName = (stdin.readLineSync() ?? "").trim();
      if (firstName.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }
        
      stdout.writeln("Efternamn(utan å, ä, ö):");
      String lastName = (stdin.readLineSync() ?? "").trim();
      if (lastName.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }
      
      repoPerson.add(Person(ssn: ssn, firstName: inputUtils.capitalizeWord(firstName), lastName: inputUtils.capitalizeWord(lastName)));
      stdout.write("Personen har lagts till.");
      sleep(Duration(seconds: 3));        
      return;
    }  
}

void managePerson() {
  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nPersoner");
    stdout.writeln("Alla personer i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    var persons = repoPerson.getAll();
    if (persons.isEmpty) {
      stdout.writeln("Inga personer finns i systemet.");
      return;
    }
    
    for (var i = 0; i < persons.length; i++) {
      stdout.writeln("${i + 1}. ${persons[i]}");
    }
    
    // Lets user choose a person to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för att redigera eller ta bort en person (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    // Check if person exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > persons.length) {
      consoleUtils.invalidChoice();
      continue;
    }
    
    consoleUtils.clearConsole();
    var selectedPerson = persons[index - 1];
    stdout.writeln("Du har valt: ${selectedPerson}");
    stdout.write("Vill du redigera (e) eller ta bort (d) denna person? ");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    // Lets user edit person
    if (action == 'e') {
      while (true) {
          
        stdout.writeln("\nPersonnr:");
        String ssn = (stdin.readLineSync() ?? "").trim();
        if (ssn.isEmpty) {
          consoleUtils.invalidChoice();
          continue;
        }

        stdout.writeln("Förnamn(utan å, ä, ö):");
        String firstName = (stdin.readLineSync() ?? "").trim(); 
        if (firstName.isEmpty) {
          consoleUtils.invalidChoice();
          continue;
        }
          
        stdout.writeln("Efternamn(utan å, ä, ö):");
        String lastName = (stdin.readLineSync() ?? "").trim();
        if (lastName.isEmpty) {
          consoleUtils.invalidChoice();
          continue;
        }
        
        Person newPerson = Person(ssn: ssn, firstName: inputUtils.capitalizeWord(firstName), lastName: inputUtils.capitalizeWord(lastName));
        repoPerson.update(selectedPerson, newPerson);
        stdout.write("Person uppdaterad.");
        sleep(Duration(seconds: 3));        
        return;
      }
    } else if (action == 'd') { // Lets user delete person 
      repoPerson.delete(selectedPerson);
      stdout.write("Person är borttagen.");
      sleep(Duration(seconds: 3)); 
    } else {
      consoleUtils.invalidChoice();
      continue;
    }
  }
}
}