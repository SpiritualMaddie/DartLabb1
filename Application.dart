import 'dart:io';
import 'Menu.dart';
import 'ModelClasses/Parking.dart';
import 'ModelClasses/ParkingSpace.dart';
import 'ModelClasses/Person.dart';
import 'ModelClasses/Vehicle.dart';
import 'Repositories/ParkingRepository.dart';
import 'Repositories/ParkingSpaceRepository.dart';
import 'Repositories/PersonRepository.dart';
import 'Repositories/VehicleRepository.dart';

class Application{
  var repoPerson = PersonRepository();
  var repoVehicle = VehicleRepository();
  var repoParkingSpace = ParkingSpaceRepository();
  var repoParking = ParkingRepository();

// ************************* START MENU ***********************************************
void startMenu(){

  while (true) {
    
    String prompt = "Vad vill du göra?\n";

    List<String> options = ["1. Parkera mitt fordon",
                            "2. Avsluta parkering",
                            "3. Parkeringar - se, lägg till/redigera", 
                            "4. Person - se, lägg till/redigera", 
                            "5. Fordon - se, lägg till/redigera", 
                            "6. Parkeringsplatser - se, lägg till/redigera", 
                            "7. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    logo();
    print(mainMenu);

    var input = stdin.readLineSync();
    clearConsole();

    switch (input) {
      case "1":
        addNewParking();    
        break;
      case "2":
        endParking();    
        break;
      case "3":
        parkingsMenu();      
        break;
      case "4":
        personMenu();        
        break;
      case "5":
        vehicleMenu();       
        break;
      case "6":
        parkingSpacesMenu();
        break;
      case "7":
        endScreen();
      default:
        invalidChoice();
    }
  }
}

// ************************* PERSON MENU **********************************************
void personMenu(){

  while (true) {
    clearConsole();
    String prompt = "Här kan du hantera användare\n";

    List<String> options = ["1. Lägg till ny användare", 
                            "2. Visa alla användare och hantera dom", 
                            "3. Tillbaka till startmenyn", 
                            "4. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    print(mainMenu);

    var input = stdin.readLineSync();
    clearConsole();

    switch (input) {
      case "1":
        addNewPerson();
        break;
      case "2":
        managePerson();
        break;
      case "3":
        startMenu();        
        break;
      case "4":
        endScreen();
      default:
        invalidChoice();
    }
  }
}

void addNewPerson(){
    while (true) {
      clearConsole();
      stdout.write("\nLägg till ny användare (Undvik å, ä, ö)\n");  
      stdout.writeln("Personnr:");
      String ssn = (stdin.readLineSync() ?? "").trim();
      if (ssn.isEmpty) {
        invalidChoice();
        continue;
      }

      stdout.writeln("Förnamn(utan å, ä, ö):");
      String firstName = (stdin.readLineSync() ?? "").trim();
      if (firstName.isEmpty) {
        invalidChoice();
        continue;
      }
        
      stdout.writeln("Efternamn(utan å, ä, ö):");
      String lastName = (stdin.readLineSync() ?? "").trim();
      if (lastName.isEmpty) {
        invalidChoice();
        continue;
      }
      
      repoPerson.add(Person(ssn: ssn, firstName: capitalizeWord(firstName), lastName: capitalizeWord(lastName)));
      stdout.write("Personen har lagts till.");
      sleep(Duration(seconds: 3));        
      break;
    }  
}

void managePerson() {
  while (true) {
    clearConsole();
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
      invalidChoice();
      continue;
    }
    
    clearConsole();
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
          invalidChoice();
          continue;
        }

        stdout.writeln("Förnamn(utan å, ä, ö):");
        String firstName = (stdin.readLineSync() ?? "").trim(); 
        if (firstName.isEmpty) {
          invalidChoice();
          continue;
        }
          
        stdout.writeln("Efternamn(utan å, ä, ö):");
        String lastName = (stdin.readLineSync() ?? "").trim();
        if (lastName.isEmpty) {
          invalidChoice();
          continue;
        }
        
        Person newPerson = Person(ssn: ssn, firstName: capitalizeWord(firstName), lastName: capitalizeWord(lastName));
        repoPerson.update(selectedPerson, newPerson);
        stdout.write("Person uppdaterad.");
        sleep(Duration(seconds: 3));        
        break;
      }
    } else if (action == 'd') { // Lets user delete person 
      repoPerson.delete(selectedPerson);
      stdout.write("Person är borttagen.");
      sleep(Duration(seconds: 3)); 
    } else {
      invalidChoice();
      continue;
    }
  }
}

// ************************* VEHICLE MENU *********************************************
void vehicleMenu(){
  clearConsole();
  String prompt = "Här kan du hantera fordon\n";

  List<String> options = ["1. Lägg till nytt fordon", 
                          "2. Visa alla fordon och hantera dom", 
                          "3. Tillbaka till startmenyn", 
                          "4. Avsluta"];
  Menu mainMenu = Menu(options:options, prompt:prompt);

  print(mainMenu);

  var input = stdin.readLineSync();
  clearConsole();

  switch (input) {
    case "1":
      addNewVehicle();      
      break;
    case "2":
      manageVehicle();       
      break;
    case "3":
      startMenu();        
      break;
    case "4":
      endScreen();
    default:
      invalidChoice();
  }
}

void addNewVehicle(){
    while (true) {
      clearConsole();
      stdout.write("\nLägg till nytt fordon (Undvik å, ä, ö)\n");  
      stdout.writeln("Regnummer:");
      String plateNumber= (stdin.readLineSync() ?? "").trim();
      if (plateNumber.isEmpty) {
        invalidChoice();
        continue;
      }

      stdout.writeln("Fordonstyp(utan å, ä, ö):");
      String vehicleType = (stdin.readLineSync() ?? "").trim();
      if (vehicleType.isEmpty) {
        invalidChoice();
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
        vehicleMenu();
      }
      if (input == 'p') {
        addNewPerson();
      }
      
      // Check if person exists
      var index = int.tryParse(input);
      if (index == null || index < 1 || index > persons.length) {
        invalidChoice();
        continue;
      }
      
      clearConsole();
      var selectedPerson = persons[index - 1];
      stdout.writeln("Du har valt: ${selectedPerson}");
      stdout.writeln("Vill du lägga till denna person som ägare? (ja/nej)");

      var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
      if (choice == 'ja') {
        repoVehicle.add(Vehicle(plateNumber: plateNumber.toUpperCase(), vehicleType: capitalizeWord(vehicleType), owner: selectedPerson));
        stdout.write("Fordonet har lagts till.");
        sleep(Duration(seconds: 3));        
        return vehicleMenu();
      }else if(choice == "nej"){
        continue;
      }else{
        invalidChoice();
        continue;
      }
    }  
}

void manageVehicle() {
  while (true) {
    clearConsole();
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
      return vehicleMenu();
    }
    
    // Check if vehicle exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > vehicles.length) {
      stdout.writeln("Ogiltigt val. Försök igen.");
      sleep(Duration(seconds: 2));
      continue;
    }
    
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
          return vehicleMenu();
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
          Vehicle newVehicle = Vehicle(plateNumber: plateNumber.toUpperCase(), vehicleType: capitalizeWord(vehicleType), owner: selectedPerson);
          repoVehicle.update(selectedVehicle, newVehicle);
          stdout.write("Fordon uppdaterad.");
          sleep(Duration(seconds: 3));        
          break; 
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

// ************************* PARKINGS MENU ********************************************
void parkingsMenu(){
  clearConsole();
  String prompt = "Här kan du hantera parkeringar\n";

  List<String> options = ["1. Lägg till en parkering", 
                          "2. Visa alla parkeringar och hantera dom", 
                          "3. Tillbaka till startmenyn", 
                          "4. Avsluta"];
  Menu mainMenu = Menu(options:options, prompt:prompt);

  print(mainMenu);

  var input = stdin.readLineSync();
  clearConsole();

  switch (input) {
    case "1":
      addNewParking();      
      break;
    case "2":
      manageParking();       
      break;
    case "3":
      startMenu();        
      break;
    case "4":
      endScreen();
    default:
      invalidChoice();
  }
}

void addNewParking(){
    while (true) {
      clearConsole();
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
        vehicleMenu();
      }
      if (vehicleChoice == 'f') {
        addNewVehicle();
      }
      
      // Check if vehicle exists
      var index = int.tryParse(vehicleChoice);
      if (index == null || index < 1 || index > vehicles.length) {
        invalidChoice();
        continue;
      }
      
      clearConsole();
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
          vehicleMenu();
        }
        if (psInput == 'p') {
          addNewParkingSpace();
        }
        
        // Check if space exists
        var index = int.tryParse(psInput);
        if (index == null || index < 1 || index > parkingSpaces.length) {
          invalidChoice();
          continue;
        }
        
        clearConsole();
        var selectedPs = parkingSpaces[index - 1];
        stdout.writeln("Du har valt:\n ${selectedPs}");
        stdout.writeln("Vill du parkera på denna plats? (ja/nej)");

        var psChoice = stdin.readLineSync()?.trim().toLowerCase() ?? "";

        if(psChoice == "ja"){

          repoParking.add(Parking(vehicle: selectedVehicle, parkingSpace: selectedPs, startTime: DateTime.now()));
          stdout.write("Parkeringen har lagts till.");
          sleep(Duration(seconds: 3));        
          return parkingsMenu();
        }else if(psChoice == "nej"){
          continue;
        }else{
          invalidChoice();
          continue;
        }

      }else if(choice == "nej"){
        continue;
      }else{
        invalidChoice();
        continue;
      }
    }  
}

void manageParking() {
  while (true) {
    clearConsole();
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
      return parkingsMenu();
    }
    
    // Check if parkings exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > parkings.length) {
      invalidChoice();
      continue;
    }
    
    clearConsole();
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
          parkingsMenu();
        }
        if (vehicleChoice == 'f') {
          addNewVehicle();
        }
        
        // Check if vehicle exists
        var index = int.tryParse(vehicleChoice);
        if (index == null || index < 1 || index > vehicles.length) {
          invalidChoice();
          continue;
        }
        
        clearConsole();
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
            parkingsMenu();
          }
          if (psInput == 'p') {
            addNewParkingSpace();
          }
          
          // Check if space exists
          var index = int.tryParse(psInput);
          if (index == null || index < 1 || index > parkingSpaces.length) {
            invalidChoice();
            continue;
          }
          
          clearConsole();
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
                return parkingsMenu();

              }else if(changeTime != "nej" && changeTime != "ja"){
                invalidChoice();
              }
            }

            Parking newParking = Parking(vehicle: selectedVehicle, parkingSpace: selectedPs, startTime: selectedParking.startTime, endTime: selectedParking.endTime);
            repoParking.update(selectedParking, newParking);
            stdout.write("Parkeringen har lagts till.");
            sleep(Duration(seconds: 3));        
            return parkingsMenu();

          }else if(psChoice == "nej"){
            continue;
          }else{
            invalidChoice();
            continue;
          }

        }else if(choice == "nej"){
          continue;
        }else{
          invalidChoice();
          continue;
        }
        
      }
    } else if (action == 'd') { // Lets user delete parking 
      repoParking.delete(selectedParking);
      stdout.write("Parkeringen är borttagen.");
      sleep(Duration(seconds: 3)); 
    } else {
      invalidChoice();
      continue;
    }
  }
}

void endParking(){
  while (true) {
    clearConsole();
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
      return startMenu();
    }
    
    // Check if parkings exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > ongoingParkings.length) {
      invalidChoice();
      continue;
    }
    
    clearConsole();
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
        return startMenu(); 

      }
    } else if (action == 'nej') {
      return startMenu();
    } else {
      invalidChoice();
      continue;
    }
  }
}

// ************************* PARKINGSPACES MENU ***************************************
void parkingSpacesMenu(){
  clearConsole();
  String prompt = "Här kan du hantera parkerinsplatser\n";

  List<String> options = ["1. Lägg till en parkeringsplats", 
                          "2. Visa alla parkeringsplatser och hantera dom", 
                          "3. Tillbaka till startmenyn", 
                          "4. Avsluta"];
  Menu mainMenu = Menu(options:options, prompt:prompt);

  print(mainMenu);

  var input = stdin.readLineSync();
  clearConsole();

  switch (input) {
    case "1":
      addNewParkingSpace();      
      break;
    case "2":
      manageParkingSpace();       
      break;
    case "3":
      startMenu();        
      break;
    case "4":
      endScreen();
    default:
      invalidChoice();
  }
}

void addNewParkingSpace(){
    while (true) {
      clearConsole();
      stdout.write("\nLägg till ny parkeringsplats (Undvik å, ä, ö)\n");  
      stdout.writeln("Zon:");
      String zone = (stdin.readLineSync() ?? "").trim();
      if (zone.isEmpty) {
        invalidChoice();
        continue;
      }

      int? pricePerHour = getValidIntPrice("Pris per timme(ange heltal):");
      if(pricePerHour == null){
        invalidChoice();
        continue;
      }
      
      repoParkingSpace.add(ParkingSpace(zone: capitalizeWord(zone), pricePerHour: pricePerHour));
      stdout.write("Parkeringsplatsen har lagts till.");
      sleep(Duration(seconds: 3));    
      return parkingSpacesMenu();    
    }  
}

void manageParkingSpace() {
  while (true) {
    clearConsole();
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
      return parkingSpacesMenu();
    }
    
    // Check if parkingspace exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > parkingSpaces.length) {
      invalidChoice();
      continue;
    }
    
    clearConsole();
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
          invalidChoice();
          continue;
        }

        int? pricePerHour = getValidIntPrice("Pris per timme(ange heltal):");
        if(pricePerHour == null){
          invalidChoice();
          continue;
        }
        
        ParkingSpace newParkingSpace = ParkingSpace(zone: zone, pricePerHour: pricePerHour);
        repoParkingSpace.update(selectedPs, newParkingSpace);
        stdout.write("Parkeringsplats uppdaterad.");
        sleep(Duration(seconds: 3));        
        return parkingSpacesMenu();
      }
    } else if (action == 'd') { // Lets user delete space 
      repoParkingSpace.delete(selectedPs);
      stdout.write("Parkeringsplats är borttagen.");
      sleep(Duration(seconds: 3)); 
      return parkingSpacesMenu();
    } else {
      invalidChoice();
      continue;
    }
  }
}

// ************************* CUSTOM METHODS ******************************************
void clearConsole(){

  // ANSI escape code to clear console
  print('\x1B[2J\x1B[0;0H');

  // Platform specific solutions that didnt work on my machine
  // if(Platform.isWindows){
  //   // Clear console on Windows
  //   Process.runSync("cls", [], runInShell: true);
  // }
  // else{
  //   // Clear console on other platforms
  //   Process.runSync("clear", [], runInShell: true);
  // }
}

String capitalizeWord(String word){
  if (word.isEmpty) return word;
  return word[0].toUpperCase() + word.substring(1).toLowerCase();
}

void invalidChoice(){
    stdout.writeln("Ogiltig input. Vänligen försök igen.");
    sleep(Duration(seconds: 2));
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

void endScreen(){
      clearConsole();
      stdout.write("Du valde att avsluta, programmet avslutar...");
      sleep(Duration(seconds: 2));
      endLogo();
      sleep(Duration(seconds: 2));
      exit(0);
}

// ************************* LOGOS ****************************************************
void logo(){
    print("""\n\n
                     `. ___
                    __,' __`.                _..----....____
        __...--.'``;.   ,.   ;``--..__     .'    ,-._    _.-'
  _..-''-------'   `'   `'   `'     O ``-''._   (,;') _,'
,'________________                          \`-._`-','
 `._              ```````````------...___   '-.._'-:
    ```--.._      ,.                     ````--...__\-.
            `.--. `-`                       ____    |  |`
              `. `.                       ,'`````.  ;  ;`
                `._`.        __________   `.      \'__/`
                   `-:._____/______/___/____`.     \  `
                               |       `._    `.    \
                               `._________`-.   `.   `.___
                                             SSt  `------'`
Bästa parkeringsappen sen automaterna på gatan!
""");
}

void endLogo(){
  print("""\n\n
  _________________________________
 |.--------_--_------------_--__--.|
 ||    /\ |_)|_)|   /\ | |(_ |_   ||
 ;;`,_/``\|__|__|__/``\|_| _)|__ ,:|
((_(-,-----------.-.----------.-.)`)
 \__ )        ,'     `.        \ _/
 :  :        |_________|       :  :
 |-'|       ,'-.-.--.-.`.      |`-|
 |_.|      (( (*  )(*  )))     |._|
 |  |       `.-`-'--`-'.'      |  |
 |-'|        | ,-.-.-. |       |._|
 |  |        |(|-|-|-|)|       |  |
 :,':        |_`-'-'-'_|       ;`.;
  \  \     ,'           `.    /._/
   \/ `._ /_______________\_,'  /
    \  / :   ___________   : \,'
     `.| |  |           |  |,'
       `.|  |           |  |
         |  | SSt       |  |""");
}

}