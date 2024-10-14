

import '../models/vehicle.dart';
import 'repository.dart';


class VehicleRepository extends Repository<Vehicle>{

  static final VehicleRepository _instance = VehicleRepository._internal();

  VehicleRepository._internal();

  factory VehicleRepository() => _instance;
}