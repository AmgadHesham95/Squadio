import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squadio/core/network/check_connectivity.dart';
import 'package:squadio/features/popular_people/data/datasources/local_data_source.dart';
import 'package:squadio/features/popular_people/data/datasources/remote_data_source.dart';
import 'package:squadio/features/popular_people/data/repositories/person_repository_imp.dart';
import 'package:squadio/features/popular_people/domain/repositories/person_repository.dart';
import 'package:squadio/features/popular_people/domain/usecases/get_popular_people_usecase.dart';
import 'package:squadio/features/popular_people/presentation/bloc/popular_people_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features - Popular People
  // Bloc
  sl.registerFactory(() => PopularPeopleBloc(getPopularPeopleUsecase: sl()));

  // Use Cases
  sl.registerLazySingleton(
      () => GetPopularPeopleUsecase(personRepository: sl(), page: 1));

  // Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImp(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkConnectivityStatus: sl(),
        page: 1,
      ));

  // Data Sources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(client: sl(), page: 1));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImp(sharedPreferences: sl()));

  /// Core
  sl.registerLazySingleton<NetworkConnectivityStatus>(
      () => NetworkConnectivityStatusImp(internetConnectionChecker: sl()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
