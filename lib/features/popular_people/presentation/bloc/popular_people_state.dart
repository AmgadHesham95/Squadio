part of 'popular_people_bloc.dart';

abstract class PopularPeopleState extends Equatable {
  const PopularPeopleState();

  @override
  List<Object> get props => [];
}

class PopularPeopleInitial extends PopularPeopleState {}

class LoadingPopularPeopleState extends PopularPeopleState {}

class LoadedPopularPeopleState extends PopularPeopleState {
  final List<PersonEntity> popularPeopleList;
  final int page;

  const LoadedPopularPeopleState(
      {required this.popularPeopleList, required this.page});

  @override
  List<Object> get props => [popularPeopleList];
}

class LoadingMorePopularPeopleState extends PopularPeopleState {
  final List<PersonEntity> popularPeopleList;
  final int page;

  const LoadingMorePopularPeopleState(
      {required this.popularPeopleList, required this.page});

  @override
  List<Object> get props => [popularPeopleList, page];
}

class ErrorPopularPeopleState extends PopularPeopleState {
  final String errorMessage;

  const ErrorPopularPeopleState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
