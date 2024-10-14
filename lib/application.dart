import 'dart:io';
import 'repositories/vehicle_repository.dart';
import 'ui/Menu.dart';

import 'repositories/parking_repository.dart';
import 'repositories/parking_space_repository.dart';
import 'repositories/person_repository.dart';
import 'ui/parking_space_ui.dart';
import 'ui/parking_ui.dart';
import 'ui/person_ui.dart';
import 'ui/vehicle_ui.dart';
import 'utils/console_utils.dart';


class Application{
  static final Application _instance = Application._internal();
  Application._internal();
  factory Application() => _instance;

  var repoPerson = PersonRepository();
  var repoVehicle = VehicleRepository();
  var repoParkingSpace = ParkingSpaceRepository();
  var repoParking = ParkingRepository();
  var consoleUtils = ConsoleUtils();
  var personUi = PersonUi();
  var vehicleUi = VehicleUi();
  var parkingSpaceUi = ParkingSpaceUi();
  var parkingUi = ParkingUi();


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

    consoleUtils.logo();
    print(mainMenu);

    var input = stdin.readLineSync();
    consoleUtils.clearConsole();

    switch (input) {
      case "1":
        parkingUi.addNewParking();    
        break;
      case "2":
        parkingUi.endParking();    
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
        consoleUtils.endScreen();
      default:
        consoleUtils.invalidChoice();
    }
  }
}

// ************************* PERSON MENU **********************************************
void personMenu(){

  while (true) {
    consoleUtils.clearConsole();
    String prompt = "Här kan du hantera användare\n";

    List<String> options = ["1. Lägg till ny användare", 
                            "2. Visa alla användare och hantera dom", 
                            "3. Tillbaka till startmenyn", 
                            "4. Avsluta"];
    Menu mainMenu = Menu(options:options, prompt:prompt);

    print(mainMenu);

    var input = stdin.readLineSync();
    consoleUtils.clearConsole();

    switch (input) {
      case "1":
        personUi.addNewPerson();
        break;
      case "2":
        personUi.managePerson();
        break;
      case "3":
        startMenu();        
        break;
      case "4":
        consoleUtils.endScreen();
      default:
        consoleUtils.invalidChoice();
    }
  }
}

// ************************* VEHICLE MENU *********************************************
void vehicleMenu(){
  consoleUtils.clearConsole();
  String prompt = "Här kan du hantera fordon\n";

  List<String> options = ["1. Lägg till nytt fordon", 
                          "2. Visa alla fordon och hantera dom", 
                          "3. Tillbaka till startmenyn", 
                          "4. Avsluta"];
  Menu mainMenu = Menu(options:options, prompt:prompt);

  print(mainMenu);

  var input = stdin.readLineSync();
  consoleUtils.clearConsole();

  switch (input) {
    case "1":
      vehicleUi.addNewVehicle();      
      break;
    case "2":
      vehicleUi.manageVehicle();       
      break;
    case "3":
      startMenu();        
      break;
    case "4":
      consoleUtils.endScreen();
    default:
      consoleUtils.invalidChoice();
  }
}

// ************************* PARKINGS MENU ********************************************
void parkingsMenu(){
  consoleUtils.clearConsole();
  String prompt = "Här kan du hantera parkeringar\n";

  List<String> options = ["1. Lägg till en parkering", 
                          "2. Visa alla parkeringar och hantera dom", 
                          "3. Tillbaka till startmenyn", 
                          "4. Avsluta"];
  Menu mainMenu = Menu(options:options, prompt:prompt);

  print(mainMenu);

  var input = stdin.readLineSync();
  consoleUtils.clearConsole();

  switch (input) {
    case "1":
      parkingUi.addNewParking();      
      break;
    case "2":
      parkingUi.manageParking();       
      break;
    case "3":
      startMenu();        
      break;
    case "4":
      consoleUtils.endScreen();
    default:
      consoleUtils.invalidChoice();
  }
}

// ************************* PARKINGSPACES MENU ***************************************
void parkingSpacesMenu(){
  consoleUtils.clearConsole();
  String prompt = "Här kan du hantera parkerinsplatser\n";

  List<String> options = ["1. Lägg till en parkeringsplats", 
                          "2. Visa alla parkeringsplatser och hantera dom", 
                          "3. Tillbaka till startmenyn", 
                          "4. Avsluta"];
  Menu mainMenu = Menu(options:options, prompt:prompt);

  print(mainMenu);

  var input = stdin.readLineSync();
  consoleUtils.clearConsole();

  switch (input) {
    case "1":
      parkingSpaceUi.addNewParkingSpace();      
      break;
    case "2":
      parkingSpaceUi.manageParkingSpace();       
      break;
    case "3":
      startMenu();        
      break;
    case "4":
      consoleUtils.endScreen();
    default:
      consoleUtils.invalidChoice();
  }
}

}