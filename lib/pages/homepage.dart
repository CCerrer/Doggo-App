import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/data/database.dart';
import 'package:flutter_counter/dogapi/blocs/app_blocs.dart';
import 'package:flutter_counter/dogapi/blocs/app_events.dart';
import 'package:flutter_counter/pages/navbar.dart';
import 'package:hive/hive.dart';
import '../dogapi/blocs/app_states.dart';
import '../dogapi/model/dog_model.dart';
import '../main.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DogBloc>(context).add(DogInitialEvent());
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<DogBloc, DogState>(
        builder: (context, state) {
          return Scaffold(
            drawer: NavBar(),
            appBar: AppBar(
              title: Text('Doggo App'),
            ),
            body: Center(
              child: Column(
                children: [
                  Center(
                    child: Text('BEM VINDO AO DOGGO APP'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
