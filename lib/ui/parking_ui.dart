import 'dart:io';

import '../models/parking.dart';
import '../repositories/parking_repository.dart';
import '../repositories/parking_space_repository.dart';
import '../repositories/vehicle_repository.dart';
import '../utils/console_utils.dart';
import '../utils/input_utils.dart';
import 'parking_space_ui.dart';
import 'vehicle_ui.dart';

class ParkingUi {
  static final ParkingUi _instance = ParkingUi._internal();
  ParkingUi._internal();
  factory ParkingUi() => _instance;

  var repoVehicle = VehicleRepository();
  var repoParkingSpace = ParkingSpaceRepository();
  var repoParking = ParkingRepository();
  var vehicleUi = VehicleUi();
  var parkingSpaceUi = ParkingSpaceUi();
  var inputUtils = InputUtils();
  var consoleUtils = ConsoleUtils();

  void addNewParking(){
    while (true) {
      consoleUtils.clearConsole();
      stdout.write("\nLägg till en ny parkering\n");  
            
      stdout.writeln("Alla fordon i systemet:");
      stdout.writeln("\n-----------------------------------------------------------\n");
    
      var vehicles = repoVehicle.getAll();
      if (vehicles.isEmpty) {
        stdout.writeln("Inga fordon finns i systemet.");
        return;
      }
    
      for (var i = 0; i < vehicles.length; i++) {
        stdout.writeln("${i + 1}. ${vehicles[i]}");
      }
      
      stdout.writeln("\n-----------------------------------------------------------\n");
      stdout.write("Välj ett nummer för att välja ett fordon att parkera (eller 'b' för att gå tillbaka): ");
      stdout.write("\nFinns inte fordonet som önskas var vänlig lägg till denne först (välj 'f' för att komma dit)");
      
      var vehicleChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
      
      if (vehicleChoice == 'b') {
        return;
      }
      if (vehicleChoice == 'f') {
        vehicleUi.addNewVehicle();
      }
      
      // Check if vehicle exists
      var index = int.tryParse(vehicleChoice);
      if (index == null || index < 1 || index > vehicles.length) {
        consoleUtils.invalidChoice();
        continue;
      }
      
      consoleUtils.clearConsole();
      var selectedVehicle = vehicles[index - 1];
      stdout.writeln("Du har valt:\n ${selectedVehicle}");
      stdout.writeln("Vill du parkera detta fordon? (ja/nej)");

      var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (choice == 'ja') {

        stdout.writeln("Alla parkeringsplatser i systemet:");
        stdout.writeln("\n-----------------------------------------------------------\n");
      
        var parkingSpaces = repoParkingSpace.getAll();
        if (parkingSpaces.isEmpty) {
          stdout.writeln("Inga parkeringsplatser finns i systemet.");
          return;
        }
      
        for (var i = 0; i < parkingSpaces.length; i++) {
          stdout.writeln("${i + 1}. ${parkingSpaces[i]}");
        }
        
        stdout.writeln("\n-----------------------------------------------------------\n");
        stdout.write("Välj ett nummer för att välja en parkeringsplats (eller 'b' för att gå tillbaka): ");
        stdout.write("\nFinns inte parkeringsplatsen som önskas var vänlig lägg till denne först (välj 'p' för att komma dit)");
        
        var psInput = stdin.readLineSync()?.trim().toLowerCase() ?? "";
        
        if (psInput == 'b') {
          return;
        }
        if (psInput == 'p') {
          parkingSpaceUi.addNewParkingSpace();
        }
        
        // Check if space exists
        var index = int.tryParse(psInput);
        if (index == null || index < 1 || index > parkingSpaces.length) {
          consoleUtils.invalidChoice();
          continue;
        }
        
        consoleUtils.clearConsole();
        var selectedPs = parkingSpaces[index - 1];
        stdout.writeln("Du har valt:\n ${selectedPs}");
        stdout.writeln("Vill du parkera på denna plats? (ja/nej)");

        var psChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

        if(psChoice == "ja"){

          repoParking.add(Parking(vehicle: selectedVehicle, parkingSpace: selectedPs, startTime: DateTime.now()));
          stdout.write("Parkeringen har lagts till.");
          sleep(Duration(seconds: 3));        
          return;
        }else if(psChoice == "nej"){
          continue;
        }else{
          consoleUtils.invalidChoice();
          continue;
        }

      }else if(choice == "nej"){
        continue;
      }else{
        consoleUtils.invalidChoice();
        continue;
      }
    }  
}

void manageParking() {
  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nParkeringar");
    stdout.writeln("Alla parkeringar i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    var parkings = repoParking.getAll();
    if (parkings.isEmpty) {
      stdout.writeln("Inga parkeringar finns i systemet.");
      return;
    }
    
    for (var i = 0; i < parkings.length; i++) {
      stdout.writeln("${i + 1}. ${parkings[i]}");
    }
    
    // Lets user choose a parkings to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för att redigera eller ta bort en parkering (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    // Check if parkings exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > parkings.length) {
      consoleUtils.invalidChoice();
      continue;
    }
    
    consoleUtils.clearConsole();
    var selectedParking = parkings[index - 1];
    stdout.writeln("Du har valt: ${selectedParking}");
    stdout.write("Vill du redigera (e) eller ta bort (d) denna parkering? ");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    // Lets user edit parking
    if (action == 'e') {
      while (true) {

        // Shows all vehicles to choose from
        stdout.writeln("Alla fordon i systemet:");
        stdout.writeln("\n-----------------------------------------------------------\n");
      
        var vehicles = repoVehicle.getAll();
        if (vehicles.isEmpty) {
          stdout.writeln("Inga fordon finns i systemet.");
          return;
        }
      
        for (var i = 0; i < vehicles.length; i++) {
          stdout.writeln("${i + 1}. ${vehicles[i]}");
        }
        
        stdout.writeln("\n-----------------------------------------------------------\n");
        stdout.write("Välj ett nummer för att ändra fordon (eller 'b' för att gå tillbaka): ");
        stdout.write("\nFinns inte fordonet som önskas var vänlig lägg till denne först (välj 'f' för att komma dit)");
        
        var vehicleChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
        
        if (vehicleChoice == 'b') {
          return;
        }
        if (vehicleChoice == 'f') {
          vehicleUi.addNewVehicle();
        }
        
        // Check if vehicle exists
        var index = int.tryParse(vehicleChoice);
        if (index == null || index < 1 || index > vehicles.length) {
          consoleUtils.invalidChoice();
          continue;
        }
        
        consoleUtils.clearConsole();
        var selectedVehicle = vehicles[index - 1];
        stdout.writeln("Du har valt: ${selectedVehicle}");
        stdout.writeln("Vill du parkera detta fordon? (ja/nej)");

        var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

        if (choice == 'ja') {

          stdout.writeln("Alla parkeringsplatser i systemet:");
          stdout.writeln("\n-----------------------------------------------------------\n");
        
          var parkingSpaces = repoParkingSpace.getAll();
          if (parkingSpaces.isEmpty) {
            stdout.writeln("Inga parkeringsplatser finns i systemet.");
            return;
          }
        
          for (var i = 0; i < parkingSpaces.length; i++) {
            stdout.writeln("${i + 1}. ${parkingSpaces[i]}");
          }
          
          stdout.writeln("\n-----------------------------------------------------------\n");
          stdout.write("Välj ett nummer för att välja en parkeringsplats (eller 'b' för att gå tillbaka): ");
          stdout.write("\nFinns inte parkeringsplatsen som önskas var vänlig lägg till denne först (välj 'p' för att komma dit)");
          
          var psInput = stdin.readLineSync()?.trim().toLowerCase() ?? "";
          
          if (psInput == 'b') {
            return;
          }
          if (psInput == 'p') {
            parkingSpaceUi.addNewParkingSpace();
          }
          
          // Check if space exists
          var index = int.tryParse(psInput);
          if (index == null || index < 1 || index > parkingSpaces.length) {
            consoleUtils.invalidChoice();
            continue;
          }
          
          consoleUtils.clearConsole();
          var selectedPs = parkingSpaces[index - 1];
          stdout.writeln("Du har valt: ${selectedPs}");
          stdout.writeln("Vill du parkera på denna plats? (ja/nej)");

          var psChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

          if(psChoice == "ja"){

            if(selectedParking.endTimeStatus == "pågående"){
              stdout.writeln("Vill du ändra sluttiden från 'pågående' till 'avslutad'? (ja/nej)");
              var changeTime = stdin.readLineSync();

              if(changeTime == "ja"){

                Parking newParking = Parking(vehicle: selectedVehicle, parkingSpace: selectedPs, startTime: selectedParking.startTime, endTime: DateTime.now());
                repoParking.update(selectedParking, newParking);
                stdout.write("Parkeringen har lagts till.");
                sleep(Duration(seconds: 3));
                return;

              }else if(changeTime != "nej" && changeTime != "ja"){
                consoleUtils.invalidChoice();
              }
            }

            Parking newParking = Parking(vehicle: selectedVehicle, parkingSpace: selectedPs, startTime: selectedParking.startTime, endTime: selectedParking.endTime);
            repoParking.update(selectedParking, newParking);
            stdout.write("Parkeringen har lagts till.");
            sleep(Duration(seconds: 3));        
            return;

          }else if(psChoice == "nej"){
            continue;
          }else{
            consoleUtils.invalidChoice();
            continue;
          }

        }else if(choice == "nej"){
          continue;
        }else{
          consoleUtils.invalidChoice();
          continue;
        }
        
      }
    } else if (action == 'd') { // Lets user delete parking 
      repoParking.delete(selectedParking);
      stdout.write("Parkeringen är borttagen.");
      sleep(Duration(seconds: 3)); 
    } else {
      consoleUtils.invalidChoice();
      continue;
    }
  }
}

void endParking(){
  while (true) {
    consoleUtils.clearConsole();
    stdout.writeln("\nParkeringar");
    stdout.writeln("Alla aktiva parkeringar i systemet:");
    stdout.writeln("\n-----------------------------------------------------------\n");
    
    var parkings = repoParking.getAll();
    var ongoingParkings = parkings.where((parking) => parking.endTime == null || parking.endTimeStatus == "pågående").toList();
    if (ongoingParkings.isEmpty) {
      stdout.writeln("Inga aktiva parkeringar finns i systemet.");
      return;
    }
    
    for (var i = 0; i < ongoingParkings.length; i++) {
      stdout.writeln("${i + 1}. ${ongoingParkings[i]}");
    }
    
    // Lets user choose a parkings to edit or delete
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för den parkeringen du vill avsluta (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    // Check if parkings exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > ongoingParkings.length) {
      consoleUtils.invalidChoice();
      continue;
    }
    
    consoleUtils.clearConsole();
    var selectedParking = ongoingParkings[index - 1];
    stdout.writeln("Du har valt: ${selectedParking}");
    stdout.write("Vill du avsluta denna parkering? (ja/nej)");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    // Lets user end parking
    if (action == 'ja') {
      while (true) {

        Parking newParking = Parking(vehicle: selectedParking.vehicle, parkingSpace: selectedParking.parkingSpace, startTime: selectedParking.startTime, endTime: DateTime.now());
        repoParking.update(selectedParking, newParking);
        stdout.write("Parkeringen har avslutats.");
        sleep(Duration(seconds: 3));    
        return;

      }
    } else if (action == 'nej') {
      return;
    } else {
      consoleUtils.invalidChoice();
      continue;
    }
  }
}
}