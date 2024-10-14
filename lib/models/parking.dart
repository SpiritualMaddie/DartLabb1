import 'parking_space.dart';
import 'vehicle.dart';

class Parking {
  //int parkingId;
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime startTime;
  DateTime? endTime;

  Parking(
      {required this.vehicle,
      required this.parkingSpace,
      required this.startTime,
      this.endTime});

  String get endTimeStatus {
    return endTime != null ? endTime.toString() : "pågående";
  }

  String formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} - "
        "${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}";
  }

  @override
  String toString() {
    String formattedStartTime = formatDateTime(startTime);
    String formattedEndTime =
        endTime != null ? formatDateTime(endTime!) : "pågående";

    return """
 Fordon: ${vehicle.plateNumber} - ${vehicle.vehicleType}
    Zone: ${parkingSpace.zone}
    Starttid: $formattedStartTime
    Sluttid:  $formattedEndTime
-----------------------------------------------------------""";
  }
}
