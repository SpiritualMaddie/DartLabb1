

import 'Person.dart';

class Vehicle {
  //int vehicleId;
  String plateNumber;
  String vehicleType;
  Person owner;

  Vehicle({required this.plateNumber, required this.vehicleType, required this.owner});

  @override
  String toString() {
    return "regnr: $plateNumber, typ: $vehicleType, ägare: ${owner.firstName} ${owner.lastName}";
  }
}