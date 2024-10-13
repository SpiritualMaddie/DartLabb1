
import 'Application.dart';
import 'DummyData.dart';

void main(List<String> args){
  Application startApp = Application();
  DummyData dummyData = DummyData();

  dummyData.populateDb();
  // startApp.startMenu();
  var allvechicle = startApp.repoVehicle.getAll();
  print(allvechicle.isEmpty);
}

