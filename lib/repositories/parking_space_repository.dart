

import '../models/parking_space.dart';
import 'repository.dart';

class ParkingSpaceRepository extends Repository<ParkingSpace>{

  static final ParkingSpaceRepository _instance = ParkingSpaceRepository._internal();

  ParkingSpaceRepository._internal();

  factory ParkingSpaceRepository() => _instance;
}