import 'dart:io';
import 'Menu.dart';
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
                            "2. Parkeringar - se aktuella/arkiverade", 
                            "3. Person - lägg till/redigera", 
                            "4. Fordon - lägg till/redigera", 
                            "5. Parkeringsplatser", 
                            "6. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    logo();
    print(mainMenu);

    var input = stdin.readLineSync();
    clearConsole();

    switch (input) {
      case "1":
        stdout.write("Parkera mitt fordon - kommer snart!");   
        sleep(Duration(seconds: 3));     
        break;
      case "2":
        stdout.write("Aktuella och arkiverade parkeringar\nTryck enter för att komma tillbaka till menyn\n\n");
        stdout.write("Parkeringar:\n-----------------------------------------------------------\n");
        repoParking.getAll().forEach(print);
        stdin.readLineSync();       
        break;
      case "3":
        personMenu();        
        break;
      case "4":
        vehicleMenu();       
        break;
      case "5":
        stdout.write("Alla parkeringsplatser\nTryck enter för att komma tillbaka till menyn\n\n");
        stdout.write("Parkeringsplatser:\n-----------------------------------------------------\n");
        repoParkingSpace.getAll().forEach(print);
        stdin.readLineSync();
        break;
      case "6":
      clearConsole();
        stdout.write("Du valde att avsluta, programmet avslutar...");
        sleep(Duration(seconds: 3));
        endLogo();
        sleep(Duration(seconds: 4));
        exit(0);
      default:
        stdout.write("Du valde något som inte fanns");
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
      clearConsole();
        stdout.write("Du valde att avsluta, programmet avslutar...");
        sleep(Duration(seconds: 3));
        endLogo();
        sleep(Duration(seconds: 4));
        exit(0);
      default:
        stdout.write("Du valde något som inte fanns");
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
        stdout.write("Du måste fylla i något");
        continue;
      }

      stdout.writeln("Förnamn(utan å, ä, ö):");
      String firstName = (stdin.readLineSync() ?? "").trim();
      if (firstName.isEmpty) {
        stdout.write("Du måste fylla i något");
        continue;
      }
        
      stdout.writeln("Efternamn(utan å, ä, ö):");
      String lastName = (stdin.readLineSync() ?? "").trim();
      if (lastName.isEmpty) {
        stdout.write("Du måste fylla i något");
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
      stdout.writeln("Ogiltigt val. Försök igen.");
      continue;
    }
    
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
          stdout.write("Du måste fylla i något");
          continue;
        }

        stdout.writeln("Förnamn(utan å, ä, ö):");
        String firstName = (stdin.readLineSync() ?? "").trim(); 
        if (firstName.isEmpty) {
          stdout.write("Du måste fylla i något");
          continue;
        }
          
        stdout.writeln("Efternamn(utan å, ä, ö):");
        String lastName = (stdin.readLineSync() ?? "").trim();
        if (lastName.isEmpty) {
          stdout.write("Du måste fylla i något");
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
      stdout.writeln("Ogiltigt val. Återgår till personlistan.");
    }
  }
}

// ************************* VEHICLE MENU *********************************************
void vehicleMenu(){
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
    clearConsole();
      stdout.write("Du valde att avsluta, programmet avslutar...");
      sleep(Duration(seconds: 3));
      endLogo();
      sleep(Duration(seconds: 4));
      exit(0);
    default:
      stdout.write("Du valde något som inte fanns");
  }
}

void addNewVehicle(){
    while (true) {
      clearConsole();
      stdout.write("\nLägg till nytt fordon (Undvik å, ä, ö)\n");  
      stdout.writeln("Regnummer:");
      String plateNumber= (stdin.readLineSync() ?? "").trim();
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
      stdout.write("Välj ett nummer för att välja som ägare (eller 'b' för att gå tillbaka): ");
      
      var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
      
      if (input == 'b') {
        vehicleMenu();
      }
      
      // Check if person exists
      var index = int.tryParse(input);
      if (index == null || index < 1 || index > persons.length) {
        stdout.writeln("Ogiltigt val. Försök igen.");
        continue;
      }
      
      var selectedPerson = persons[index - 1];
      stdout.writeln("Du har valt: ${selectedPerson}");
      stdout.writeln("Vill du lägga till denna person som ägare? (ja/nej)");

      var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
      if (choice == 'nej') {
        continue;
      }else if(choice == "ja"){
        return;
      }else{
        stdout.writeln("Ogiltigt val. Försök igen.");
        continue;
      }

      // stdout.writeln("Ägare(utan å, ä, ö):");
      // String lastName = (stdin.readLineSync() ?? "").trim();
      // if (lastName.isEmpty) {
      //   stdout.write("Du måste fylla i något");
      //   continue;
      // }
      
      repoVehicle.add(Vehicle(plateNumber: plateNumber.toUpperCase(), vehicleType: capitalizeWord(vehicleType), owner: selectedPerson));
      stdout.write("Fordonet har lagts till.");
      sleep(Duration(seconds: 3));        
      break;
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
      return;
    }
    
    // Check if vehicle exists
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > vehicles.length) {
      stdout.writeln("Ogiltigt val. Försök igen.");
      continue;
    }
    
    var selectedVehicle = vehicles[index - 1];
    stdout.writeln("Du har valt: ${selectedVehicle}");
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
          
        stdout.writeln("Alla personer i systemet:");
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
        stdout.write("Välj ett nummer för att välja som ägare (eller 'b' för att gå tillbaka): ");
        
        var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
        
        if (input == 'b') {
          vehicleMenu();
        }
        
        // Check if person exists
        var index = int.tryParse(input);
        if (index == null || index < 1 || index > persons.length) {
          stdout.writeln("Ogiltigt val. Försök igen.");
          continue;
        }
        
        var selectedPerson = persons[index - 1];
        stdout.writeln("Du har valt: ${selectedPerson}");
        stdout.writeln("Vill du lägga till denna person som ägare? (ja/nej)");

        var choice = stdin.readLineSync()?.trim().toLowerCase() ?? "";
        if (choice == 'nej') {
          return;
        }else if(choice == "nej"){
          continue;
        }
        
        Vehicle newVehicle = Vehicle(plateNumber: plateNumber, vehicleType: vehicleType, owner: selectedPerson);
        repoVehicle.update(selectedVehicle, newVehicle);
        stdout.write("Fordon uppdaterad.");
        sleep(Duration(seconds: 3));        
        break;
      }
    } else if (action == 'd') { // Lets user delete person 
      repoVehicle.delete(selectedVehicle);
      stdout.write("Fordonet är borttagen.");
      sleep(Duration(seconds: 3)); 
    } else {
      stdout.writeln("Ogiltigt val. Återgår till fordonslistan.");
      vehicleMenu();
    }
  }
}

// ************************* PARKINGS MENU ********************************************
void parkingsMenu(){

}

// ************************* PARKINGSPACES MENU ***************************************
void parkingSpacesMenu(){

}


// ************************* CLEARS THE CONSOLE ***************************************
void clearConsole(){

  // ANSI escape code to clear console
  print('\x1B[2J\x1B[0;0H');

  // Platform specific solutions that didnt work
  // if(Platform.isWindows){
  //   // Clear console on Windows
  //   Process.runSync("cls", [], runInShell: true);
  // }
  // else{
  //   // Clear console on other platforms
  //   Process.runSync("clear", [], runInShell: true);
  // }
}

// ************************* CAPITALIZE WORDS *****************************************
String capitalizeWord(String word){
  if (word.isEmpty) return word;
  return word[0].toUpperCase() + word.substring(1).toLowerCase();
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