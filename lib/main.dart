import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadio/features/popular_people/presentation/bloc/popular_people_bloc.dart';
import 'package:squadio/features/popular_people/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<PopularPeopleBloc>()..add(GetPopularPeopleEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Squadio',
        home: HomePage(),
      ),
    );
  }
}
