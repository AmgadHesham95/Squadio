import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadio/features/popular_people/presentation/bloc/popular_people_bloc.dart';
import 'package:squadio/features/popular_people/presentation/widgets/error_message_widget.dart';
import 'package:squadio/features/popular_people/presentation/widgets/popular_people_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Popular People'),
          centerTitle: true,
          backgroundColor: Colors.indigo[900],
        ),
        body: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
            builder: (BuildContext context, PopularPeopleState state) {
          if (state is LoadingPopularPeopleState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorPopularPeopleState) {
            return ErrorMessageWidget(errorMessage: state.errorMessage);
          } else if (state is LoadedPopularPeopleState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PopularPeopleListWidget(
                  popularPeopleList: state.popularPeopleList, page: state.page),
            );
          } else if (state is LoadingMorePopularPeopleState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PopularPeopleListWidget(
                  popularPeopleList: state.popularPeopleList, page: state.page),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PopularPeopleBloc>(context).add(ReloadPopularPeopleEvent());
  }
}
