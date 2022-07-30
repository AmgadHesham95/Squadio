import 'package:dartz/dartz.dart';
import 'package:squadio/features/popular_people/domain/entities/person_entity.dart';
import 'package:squadio/features/popular_people/domain/repositories/person_repository.dart';

import '../../../../core/exceptions/failures.dart';

class GetPopularPeopleUsecase {
  final PersonRepository personRepository;
  final int page;

  GetPopularPeopleUsecase({required this.personRepository, required this.page});

  Future<Either<Failure, List<PersonEntity>>> call(page) async {
    return await personRepository.getPopularPeople(page);
  }
}
