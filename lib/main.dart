import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/dogapi/blocs/app_events.dart';
import 'package:flutter_counter/dogapi/blocs/app_states.dart';
import 'package:flutter_counter/dogapi/model/dog_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/database.dart';
import 'dogapi/blocs/app_blocs.dart';
import 'pages/homepage.dart';

Future<void> main() async {
  // inicializando o hive
  await Hive.initFlutter();
  // registrando o modelo de cachorro
  Hive.registerAdapter(DogModelAdapter());
  await Hive.openBox<DogModel>('dogSavedBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DogBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        title: 'Doggo App',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
