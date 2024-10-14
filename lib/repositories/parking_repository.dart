

import '../models/parking.dart';
import 'repository.dart';

class ParkingRepository extends Repository<Parking>{

  static final ParkingRepository _instance = ParkingRepository._internal();

  ParkingRepository._internal();

  factory ParkingRepository() => _instance;

}