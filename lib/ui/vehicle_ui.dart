import 'dart:io';

import '../models/vehicle.dart';
import '../repositories/person_repository.dart';
import '../repositories/vehicle_repository.dart';
import '../utils/console_utils.dart';
import '../utils/input_utils.dart';
import 'person_ui.dart';

class VehicleUi {
  static final VehicleUi _instance = VehicleUi._internal();
  VehicleUi._internal();
  factory VehicleUi() => _instance;

  var repoPerson = PersonRepository();
  var repoVehicle = VehicleRepository();
  var personUi = PersonUi();
  var inputUtils = InputUtils();
  var consoleUtils = ConsoleUtils();

  void addNewVehicle(){
    while (true) {
      consoleUtils.clearConsole();
      stdout.write("\nLägg till nytt fordon (Undvik å, ä, ö)\n");  
      stdout.writeln("Regnummer:");
      String plateNumber= (stdin.readLineSync() ?? "").trim();
      if (plateNumber.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }

      stdout.writeln("Fordonstyp(utan å, ä, ö):");
      String vehicleType = (stdin.readLineSync() ?? "").trim();
      if (vehicleType.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }
        
        // Person owner
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
      
      stdout.writeln("\n-----------------------------------------------------------\n");
      stdout.write("Välj ett nummer för att välja en person som ägare (eller 'b' för att gå tillbaka): ");
      stdout.write("\nFinns inte personen som önskas var vänlig lägg till denne först (välj 'p' för att komma dit)");
      
      var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
      
      if (input == 'b') {
        return;
      }
      if (input == 'p') {
        personUi.addNewPerson();
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
      stdout.writeln("Vill du lägga till denna person som ägare? (ja/nej)");

      var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
      if (choice == 'ja') {
        repoVehicle.add(Vehicle(plateNumber: plateNumber.toUpperCase(), vehicleType: inputUtils.capitalizeWord(vehicleType), owner: selectedPerson));
        stdout.write("Fordonet har lagts till.");
        sleep(Duration(seconds: 3));        
        return;
      }else if(choice == "nej"){
        continue;
      }else{
        consoleUtils.invalidChoice();
        continue;
      }
    }  
}

void manageVehicle() {
  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nFordon");
    stdout.writeln("Alla fordon i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    var vehicles = repoVehicle.getAll();
    if (vehicles.isEmpty) {
      stdout.writeln("Inga fordon finns i systemet.");
      sleep(Duration(seconds: 3));
      return;
    }
    
    for (var i = 0; i < vehicles.length; i++) {
      stdout.writeln("${i + 1}. ${vehicles[i]}");
    }
    
    // Lets user choose a vehicle to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för att redigera eller ta bort ett fordon (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    // Check if vehicle exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > vehicles.length) {
      stdout.writeln("Ogiltigt val. Försök igen.");
      sleep(Duration(seconds: 2));
      continue;
    }
    
    consoleUtils.clearConsole();
    
    var selectedVehicle = vehicles[index - 1];
    stdout.writeln("Du har valt: \n${selectedVehicle}");
    stdout.write("Vill du redigera (e) eller ta bort (d) detta fordon? ");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    // Lets user edit vehicle
    if (action == 'e') {
      while (true) {
          
        stdout.writeln("\nRegnr:");
        String plateNumber = (stdin.readLineSync() ?? "").trim();
        if (plateNumber.isEmpty) {
          stdout.write("Du måste fylla i något");
          continue;
        }

        stdout.writeln("Fordonstyp(utan å, ä, ö):");
        String vehicleType = (stdin.readLineSync() ?? "").trim(); 
        if (vehicleType.isEmpty) {
          stdout.write("Du måste fylla i något");
          continue;
        }
          
        stdout.writeln("\nAlla personer i systemet:");
        stdout.writeln("\n-----------------------------------------------------------\n");
      
        var persons = repoPerson.getAll();
        if (persons.isEmpty) {
          stdout.writeln("Det finns inga personer i systemet att välja som ägare. Lägg till en person först");
          sleep(Duration(seconds: 4));
          return;
        }
      
        for (var i = 0; i < persons.length; i++) {
          stdout.writeln("${i + 1}. ${persons[i]}");
        }
        
        stdout.writeln("\n-----------------------------------------------------------\n");
        stdout.write("Välj ett nummer på en person för att välja denne som ägare (eller 'b' för att gå tillbaka): ");
        
        var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
        
        if (input == 'b') {
          return;
        }
        
        // Check if person exists
        var index = int.tryParse(input);
        if (index == null || index < 1 || index > persons.length) {
          stdout.writeln("Ogiltigt val. Försök igen.");
          sleep(Duration(seconds: 2));
          continue;
        }
        
        var selectedPerson = persons[index - 1];
        stdout.writeln("Du har valt: \n${selectedPerson}");
        stdout.writeln("Vill du lägga till denna person som ägare? (ja/nej)");

        var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
        if (choice == 'ja') {
          Vehicle newVehicle = Vehicle(plateNumber: plateNumber.toUpperCase(), vehicleType: inputUtils.capitalizeWord(vehicleType), owner: selectedPerson);
          repoVehicle.update(selectedVehicle, newVehicle);
          stdout.write("Fordon uppdaterad.");
          sleep(Duration(seconds: 3));        
          return; 
        }else if(choice == "nej"){
          continue;
        }else{
          stdout.writeln("Ogiltigt val.");
          sleep(Duration(seconds: 2));
          continue;
        }        
      }
    } else if (action == 'd') { // Lets user delete person 
      repoVehicle.delete(selectedVehicle);
      stdout.write("Fordonet är borttagen.");
      sleep(Duration(seconds: 3)); 
    } else {
      stdout.writeln("Ogiltigt val.");
      sleep(Duration(seconds: 2));
      continue;
    }
  }
}
}