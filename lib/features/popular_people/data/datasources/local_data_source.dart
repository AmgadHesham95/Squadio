import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squadio/core/exceptions/exceptions.dart';
import 'package:squadio/features/popular_people/data/models/person_model.dart';

abstract class LocalDataSource {
  Future<List<PersonModel>> getCachedPopularPeople();
  Future<Unit> saveCachedPopularPeople(List<PersonModel> popularPeople);
}

const cachedPopularPeople = 'CACHED_POPULAR_PEOPLE';

class LocalDataSourceImp implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImp({required this.sharedPreferences});

  @override
  Future<Unit> saveCachedPopularPeople(List<PersonModel> popularPeople) async {
    List<Map<String, dynamic>> popularPeopleToJson = popularPeople
        .map<Map<String, dynamic>>((personModel) => personModel.toJson())
        .toList();
    sharedPreferences.setString(
        cachedPopularPeople, json.encode(popularPeopleToJson));
    return unit;
  }

  @override
  Future<List<PersonModel>> getCachedPopularPeople() async {
    final jsonString = sharedPreferences.getString(cachedPopularPeople);
    if (jsonString != null) {
      List<Map<String, dynamic>> decodedJson = json.decode(jsonString);
      List<PersonModel> jsonToPersonModel = decodedJson
          .map<PersonModel>(
              (jsonPersonModel) => PersonModel.fromJson(jsonPersonModel))
          .toList();
      return jsonToPersonModel;
    } else {
      throw EmptyCacheException();
    }
  }
}
