import 'package:flutter_counter/dogapi/model/dog_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<DogModel> getDogsFromBox() =>
      Hive.box<DogModel>('dogSavedBox');
}