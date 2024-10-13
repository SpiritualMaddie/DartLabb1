

import '../ModelClasses/ParkingSpace.dart';
import 'Repository.dart';

class ParkingSpaceRepository extends Repository<ParkingSpace>{

  static final ParkingSpaceRepository _instance = ParkingSpaceRepository._internal();

  ParkingSpaceRepository._internal();

  factory ParkingSpaceRepository() => _instance;
}