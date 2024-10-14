import 'dart:io';

class ConsoleUtils {
  
  void clearConsole() {
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

  void invalidChoice() {
    stdout.writeln("Ogiltig input. Vänligen försök igen.");
    sleep(Duration(seconds: 2));
  }

  void endScreen() {
    clearConsole();
    stdout.write("Du valde att avsluta, programmet avslutar...");
    sleep(Duration(seconds: 2));
    endLogo();
    sleep(Duration(seconds: 2));
    exit(0);
  }

  // ************************* LOGOS ****************************************************
  void logo() {
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

  void endLogo() {
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
