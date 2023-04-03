import 'package:hive/hive.dart';

part 'dog_model.g.dart';

@HiveType(typeId: 1)
class DogModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String url;


  DogModel({
    required this.name,
    required this.url,
  });

  factory DogModel.fromJson(Map<String, dynamic> json) {
    return DogModel(
      name: json['name'],
      url: json['url'],
    );
  }
}
