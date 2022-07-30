import 'package:squadio/core/exceptions/exceptions.dart';
import 'package:squadio/core/network/check_connectivity.dart';
import 'package:squadio/features/popular_people/data/datasources/local_data_source.dart';
import 'package:squadio/features/popular_people/data/datasources/remote_data_source.dart';
import 'package:squadio/features/popular_people/domain/entities/person_entity.dart';
import 'package:squadio/core/exceptions/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:squadio/features/popular_people/domain/repositories/person_repository.dart';

class PersonRepositoryImp implements PersonRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkConnectivityStatus networkConnectivityStatus;
  final int page;

  PersonRepositoryImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkConnectivityStatus,
      required this.page});

  @override
  Future<Either<Failure, List<PersonEntity>>> getPopularPeople(page) async {
    if (await networkConnectivityStatus.isConnected) {
      try {
        final remotePopularPeopleList =
            await remoteDataSource.getPopularPeople(page);
        localDataSource.saveCachedPopularPeople(remotePopularPeopleList);
        return Right(remotePopularPeopleList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPopularPeopleList =
            await localDataSource.getCachedPopularPeople();
        return Right(localPopularPeopleList);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
