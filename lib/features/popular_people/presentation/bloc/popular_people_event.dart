part of 'popular_people_bloc.dart';

abstract class PopularPeopleEvent extends Equatable {
  const PopularPeopleEvent();

  @override
  List<Object> get props => [];
}

class GetPopularPeopleEvent extends PopularPeopleEvent {}

class ReloadPopularPeopleEvent extends PopularPeopleEvent {}

class LoadMorePopularPeopleEvent extends PopularPeopleEvent {}
