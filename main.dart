
import 'dart:io';

void main(){

  var duration = const Duration(seconds: 3); 
  var duration2 = const Duration(seconds: 4); 
  while(true){

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
""");
    print("Välkommen till parkeringsappen 2.0");
    print("""Vad vill du hantera?:
          1. Parkera mitt fordon
          2. Se aktuella/arkiverade parkeringar
          3. Lägga till/redigera person
          4. Lägga till/redigera fordon
          5. Se parkeringsplatser
          6. Avsluta """);

    var input = stdin.readLineSync();
    clearConsole();

    switch (input) {
      case "1":
        stdout.write("Du valde Parkera mitt fordon");        
        break;
      case "2":
        stdout.write("Du valde Se aktuella/arkiverade parkeringar");        
        break;
      case "3":
        stdout.write("Du valde Lägga till/redigera person");        
        break;
      case "4":
        stdout.write("Du valde Lägga till/redigera fordon");        
        break;
      case "5":
        stdout.write("Du valde Se parkeringsplatser");        
        break;
      case "6":
      clearConsole();
        stdout.write("Du valde att avsluta, programmet avslutar...");
        sleep(duration);
        ending();
        sleep(duration2);
        exit(0);
      default:
        stdout.write("Du valde något som inte fanns");
    }
  }
}

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

void ending(){
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
         |  | SSt       |  |
""");
}