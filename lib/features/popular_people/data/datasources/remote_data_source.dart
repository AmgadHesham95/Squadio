import 'dart:convert';

import 'package:squadio/core/exceptions/exceptions.dart';
import 'package:squadio/core/strings/api.dart';
import 'package:squadio/features/popular_people/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<PersonModel>> getPopularPeople(int page);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final http.Client client;
  final int page;

  RemoteDataSourceImp({required this.client, required this.page});

  @override
  Future<List<PersonModel>> getPopularPeople(page) async {
    final response = await client.get(
        Uri.parse('$baseUrl/3/$endPoint?$apiKey&$language&page=$page'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson =
          json.decode(response.body) as Map<String, dynamic>;

      final List<PersonModel> popularPeopleList = decodedJson['results']
          .map<PersonModel>((personModel) => PersonModel.fromJson(personModel))
          .toList();

      final int totalPages = decodedJson['total_pages']; // 500

      if (totalPages < page) {
        throw ServerException();
      }

      return popularPeopleList;
    } else {
      throw ServerException();
    }
  }
}
