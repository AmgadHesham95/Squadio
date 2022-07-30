import 'package:flutter/material.dart';
import 'package:squadio/features/popular_people/domain/entities/person_entity.dart';
import 'package:squadio/features/popular_people/presentation/widgets/person_details_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.person}) : super(key: key);

  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: Colors.red[900],
      ),
      body: PersonDetailsWidget(person: person),
    );
  }
}
