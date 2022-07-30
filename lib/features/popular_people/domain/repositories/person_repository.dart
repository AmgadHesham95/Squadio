import 'package:dartz/dartz.dart';
import 'package:squadio/features/popular_people/domain/entities/person_entity.dart';

import '../../../../core/exceptions/failures.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getPopularPeople(int page);
}
