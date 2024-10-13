

class ParkingSpace {
  //int parkingSpaceId;
  String zone;
  double pricePerHour;

  ParkingSpace({required this.zone, required this.pricePerHour});

  @override
  String toString() {
    return "${pricePerHour} kr/h \t - zone: $zone";
  }
}