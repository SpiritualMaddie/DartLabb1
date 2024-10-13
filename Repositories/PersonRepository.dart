

import '../ModelClasses/Person.dart';
import 'Repository.dart';

class PersonRepository extends Repository<Person>{

  static final PersonRepository _instance = PersonRepository._internal();

  PersonRepository._internal();

  factory PersonRepository() => _instance;

  }