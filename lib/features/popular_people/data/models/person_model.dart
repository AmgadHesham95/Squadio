import 'package:squadio/features/popular_people/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel(
      {required super.name,
      required super.knownForDepartment,
      required super.profilePath,
      required super.gender,
      required super.popularity});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
        name: json['name'],
        knownForDepartment: json['known_for_department'],
        profilePath: json['profile_path'] ?? '',
        gender: json['gender'],
        popularity: json['popularity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'known_for_department': knownForDepartment,
      'profile_path': profilePath,
      'gender': gender,
      'popularity': popularity,
    };
  }
}
