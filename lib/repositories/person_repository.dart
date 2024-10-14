

import '../models/person.dart';
import 'repository.dart';

class PersonRepository extends Repository<Person>{

  static final PersonRepository _instance = PersonRepository._internal();

  PersonRepository._internal();

  factory PersonRepository() => _instance;

  }