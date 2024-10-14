import 'dart:io';

import '../models/parking_space.dart';
import '../repositories/parking_space_repository.dart';
import '../utils/console_utils.dart';
import '../utils/input_utils.dart';

class ParkingSpaceUi {
  static final ParkingSpaceUi _instance = ParkingSpaceUi._internal();
  ParkingSpaceUi._internal();
  factory ParkingSpaceUi() => _instance;

  var repoParkingSpace = ParkingSpaceRepository();
  var inputUtils = InputUtils();
  var consoleUtils = ConsoleUtils();

  void addNewParkingSpace(){
    while (true) {
      consoleUtils.clearConsole();
      stdout.write("\nLägg till ny parkeringsplats (Undvik å, ä, ö)\n");  
      stdout.writeln("Zon:");
      String zone = (stdin.readLineSync() ?? "").trim();
      if (zone.isEmpty) {
        consoleUtils.invalidChoice();
        continue;
      }

      int? pricePerHour = inputUtils.getValidIntPrice("Pris per timme(ange heltal):");
      if(pricePerHour == null){
        consoleUtils.invalidChoice();
        continue;
      }
      
      repoParkingSpace.add(ParkingSpace(zone: inputUtils.capitalizeWord(zone), pricePerHour: pricePerHour));
      stdout.write("Parkeringsplatsen har lagts till.");
      sleep(Duration(seconds: 3));    
      return;    
    }  
}

void manageParkingSpace() {
  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nParkeringsplatser");
    stdout.writeln("Alla platser i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    var parkingSpaces = repoParkingSpace.getAll();
    if (parkingSpaces.isEmpty) {
      stdout.writeln("Inga parkeringsplatser finns i systemet.");
      return;
    }
    
    for (var i = 0; i < parkingSpaces.length; i++) {
      stdout.writeln("${i + 1}. ${parkingSpaces[i]}");
    }
    
    // Lets user choose a parkingspace to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för att redigera eller ta bort en parkeringsplats (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    // Check if parkingspace exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > parkingSpaces.length) {
      consoleUtils.invalidChoice();
      continue;
    }
    
    consoleUtils.clearConsole();
    var selectedPs = parkingSpaces[index - 1];
    stdout.writeln("Du har valt:\n ${selectedPs}");
    stdout.write("Vill du redigera (e) eller ta bort (d) denna plats? ");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    // Lets user edit space
    if (action == 'e') {
      while (true) {
          
        stdout.writeln("\nZone(utan å, ä, ö):");
        String zone = (stdin.readLineSync() ?? "").trim();
        if (zone.isEmpty) {
          consoleUtils.invalidChoice();
          continue;
        }

        int? pricePerHour = inputUtils.getValidIntPrice("Pris per timme(ange heltal):");
        if(pricePerHour == null){
          consoleUtils.invalidChoice();
          continue;
        }
        
        ParkingSpace newParkingSpace = ParkingSpace(zone: zone, pricePerHour: pricePerHour);
        repoParkingSpace.update(selectedPs, newParkingSpace);
        stdout.write("Parkeringsplats uppdaterad.");
        sleep(Duration(seconds: 3));        
        return;
      }
    } else if (action == 'd') { // Lets user delete space 
      repoParkingSpace.delete(selectedPs);
      stdout.write("Parkeringsplats är borttagen.");
      sleep(Duration(seconds: 3)); 
      return;
    } else {
      consoleUtils.invalidChoice();
      continue;
    }
  }
}
}