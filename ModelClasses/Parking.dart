import 'ParkingSpace.dart';
import 'Vehicle.dart';

class Parking {
  //int parkingId;
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime startTime;
  DateTime? endTime;

  Parking({
    required this.vehicle, 
    required this.parkingSpace, 
    required this.startTime, 
    this.endTime });

    String get endTimeStatus{
      return endTime != null ? endTime.toString() : "pågående";
    }


  @override
  String toString() {
    return "fordon: ${vehicle.plateNumber}, starttid: $startTime sluttid: $endTimeStatus \t zone: ${parkingSpace.zone}, ";
  }
}