import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final String name;
  final String knownForDepartment;
  final String profilePath;
  final int gender;
  final double popularity;

  const PersonEntity(
      {required this.name,
      required this.knownForDepartment,
      required this.profilePath,
      required this.gender,
      required this.popularity});

  @override
  List<Object?> get props => [
        name,
        knownForDepartment,
        profilePath,
        gender,
        popularity,
      ];
}
