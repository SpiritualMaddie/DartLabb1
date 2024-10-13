

import '../ModelClasses/Parking.dart';
import 'Repository.dart';

class ParkingRepository extends Repository<Parking>{

  static final ParkingRepository _instance = ParkingRepository._internal();

  ParkingRepository._internal();

  factory ParkingRepository() => _instance;

}