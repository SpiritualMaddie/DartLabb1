import 'dart:io';
import 'Menu.dart';
import 'ModelClasses/Person.dart';
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
                            "2. Se aktuella/arkiverade parkeringar", 
                            "3. Lägga till/redigera person", 
                            "4. Lägga till/redigera fordon", 
                            "5. Se parkeringsplatser", 
                            "6. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    logo();
    print(mainMenu);

    var input = stdin.readLineSync();
    clearConsole();

    switch (input) {
      case "1":
        stdout.write("Du valde Parkera mitt fordon");        
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
        stdout.write("Du valde Lägga till/redigera fordon");        
        break;
      case "5":
      // Något funkar inte **************************************************************************************<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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

// ************************* VEHICLE MENU *********************************************
void vehicleMenu(){
  String prompt = "Här kan du hantera fordon\n";

  List<String> options = ["1. Lägg till nytt fordon", 
                          "2. Visa alla fordon och hantera dom", 
                          "3. Tillbaka till startmenyn", 
                          "4. Avsluta"];
  Menu mainMenu = Menu(options:options, prompt:prompt);

  logo();
  print(mainMenu);

  var input = stdin.readLineSync();
  clearConsole();

  switch (input) {
    case "1":
      stdout.write("Du valde Lägg till nytt fordon");        
      break;
    case "2":
      stdout.write("Du valde Visa alla fordon och hantera dom");        
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

// ************************* PARKINGS MENU ********************************************
void parkingsMenu(){

}

// ************************* PARKINGSPACES MENU ***************************************
void parkingSpacesMenu(){

}


// Behöver bättre felhantering **************************************<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
void addNewPerson(){
    stdout.write("Lägg till ny användare (Undvik å, ä, ö)\nPersonnr:");
    String ssn = stdin.readLineSync() ?? "ssn";

    stdout.write("Förnamn:");
    String firstName = stdin.readLineSync() ?? "firstname";

    stdout.write("Efternamn:");
    String lastName = stdin.readLineSync() ?? "lastname";

    repoPerson.add(Person(ssn: ssn, firstName: firstName, lastName: lastName));     

    stdout.write("Personen har lagts till. \nTryck enter för att gå tillbaka till personmenyn");
    stdin.readLineSync();   
}

void managePerson() {
  while (true) {
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
    
    stdout.writeln("\n-----------------------------------------------------------\n");
    stdout.write("Välj ett nummer för att redigera eller ta bort en person (eller 'b' för att gå tillbaka): ");
    
    var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (input == 'b') {
      return;
    }
    
    var index = int.tryParse(input);
    if (index == null || index < 1 || index > persons.length) {
      stdout.writeln("Ogiltigt val. Försök igen.");
      continue;
    }
    
    var selectedPerson = persons[index - 1];
    stdout.writeln("Du har valt: ${selectedPerson}");
    stdout.write("Vill du redigera (e) eller ta bort (d) denna person? ");
    
    var action = stdin.readLineSync()?.trim().toLowerCase() ?? "";
    
    if (action == 'e') {
      stdout.writeln("Personnr:");
      String ssn = stdin.readLineSync() ?? "ssn"; 
      stdout.writeln("Förnamn(utan å, ä, ö):");
      String firstName = stdin.readLineSync() ?? "firstName"; 
      stdout.writeln("Efternamn(utan å, ä, ö):");
      String lastName = stdin.readLineSync() ?? "lastName";

      Person newPerson = Person(ssn: ssn, firstName: firstName, lastName: lastName);
      repoPerson.update(selectedPerson, newPerson);
    } else if (action == 'd') {
      repoPerson.delete(selectedPerson);
    } else {
      stdout.writeln("Ogiltigt val. Återgår till personlistan.");
    }
  }
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