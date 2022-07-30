import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:squadio/core/exceptions/failures.dart';
import 'package:squadio/core/strings/failures.dart';
import 'package:squadio/features/popular_people/domain/entities/person_entity.dart';
import 'package:squadio/features/popular_people/domain/usecases/get_popular_people_usecase.dart';

part 'popular_people_event.dart';
part 'popular_people_state.dart';

class PopularPeopleBloc extends Bloc<PopularPeopleEvent, PopularPeopleState> {
  final GetPopularPeopleUsecase getPopularPeopleUsecase;
  int page = 1;
  PopularPeopleBloc({required this.getPopularPeopleUsecase})
      : super(PopularPeopleInitial()) {
    on<PopularPeopleEvent>((event, emit) async {
      if (event is GetPopularPeopleEvent || event is ReloadPopularPeopleEvent) {
        emit(LoadingPopularPeopleState());
        page = 1;
        final failureOrPopularPeople = await getPopularPeopleUsecase(page);
        failureOrPopularPeople.fold((failure) {
          emit(ErrorPopularPeopleState(
              errorMessage: _mapFailureToMessage(failure)));
        }, (popularPeopleList) {
          emit(LoadedPopularPeopleState(
              popularPeopleList: popularPeopleList, page: 1));
        });
      } else if (event is LoadMorePopularPeopleEvent) {
        emit(LoadingPopularPeopleState());
        page += 1;
        final failureOrPopularPeople = await getPopularPeopleUsecase(page);
        failureOrPopularPeople.fold((failure) {
          emit(ErrorPopularPeopleState(
              errorMessage: _mapFailureToMessage(failure)));
        }, (popularPeopleList) {
          emit(LoadingMorePopularPeopleState(
              popularPeopleList: popularPeopleList, page: page));
        });
      }
    });
  }
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case EmptyCacheFailure:
      return emptyCacheFailureMessage;
    case OfflineFailure:
      return offlineFailureMessage;

    default:
      return 'Unexpected Error, Please try again later !';
  }
}
