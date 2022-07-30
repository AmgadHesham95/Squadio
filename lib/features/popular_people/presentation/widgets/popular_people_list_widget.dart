import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadio/features/popular_people/domain/entities/person_entity.dart';
import 'package:squadio/features/popular_people/presentation/bloc/popular_people_bloc.dart';
import 'package:squadio/features/popular_people/presentation/pages/details_page.dart';

class PopularPeopleListWidget extends StatefulWidget {
  const PopularPeopleListWidget(
      {Key? key, required this.popularPeopleList, required this.page})
      : super(key: key);

  final List<PersonEntity> popularPeopleList;
  final int page;

  @override
  State<PopularPeopleListWidget> createState() =>
      _PopularPeopleListWidgetState();
}

class _PopularPeopleListWidgetState extends State<PopularPeopleListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        controller: _scrollController
          ..addListener(() {
            if (_scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent) {
              BlocProvider.of<PopularPeopleBloc>(context)
                  .add(LoadMorePopularPeopleEvent());
            }
          }),
        itemCount: widget.popularPeopleList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              widget.popularPeopleList[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.popularPeopleList[index].knownForDepartment,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DetailsPage(
                    person: widget.popularPeopleList[index],
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
