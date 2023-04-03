
import 'dart:async';
import 'dart:convert';
import 'package:flutter_counter/dogapi/model/dog_model.dart';
import 'package:http/http.dart' as http;

class DogDatabase {
  /// Finds a [Dog] `/v1/search/?name=(query)`.
  static Future<List<DogModel>> dogSearch(int query, int limit) async {
    final dogRequest = Uri.https(
      'api.thedogapi.com',
      '/v1/images/search',
      {'breed_ids': query.toString(), 'limit': limit.toString()},
    );
    String key =
        'live_yEqARSLRlD1l3EfUSvuMfp4GVH4cf8mIVfEF3s5zS3HG8cSTXCKwv438uRmlUJ4Z';

    final response = await http.get(dogRequest, headers: {'x-api-key': key});

    if (response.statusCode == 200) {
      final dogJson = jsonDecode(response.body);
      List<Map<String, dynamic>> dogs = [];

      for (int i = 0; i < limit; i++) {
        final id = dogJson[i]['id'];
        final name = dogJson[i]['breeds'][0]['name'];
        final url = dogJson[i]['url'];
        Map<String, String> dog = {'id': id, 'name': name, 'url': url};
        dogs.add(dog);
      }

      return dogs.map(((e) => DogModel.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<List<DogModel>> groupDogs(int limit) async {
    final List<DogModel> dogs = [];

    final akita = await dogSearch(6, limit);
    final borderCollie = await dogSearch(50, limit);
    final americanBully = await dogSearch(11, limit);

    dogs.addAll(americanBully);
    dogs.addAll(akita);
    dogs.addAll(borderCollie);

    return dogs;
  }
}
