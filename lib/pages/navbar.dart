import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/pages/downloads.dart';
import 'package:flutter_counter/pages/search.dart';

import '../dogapi/blocs/app_blocs.dart';
import '../dogapi/blocs/app_events.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 190,
      child: ListView(
        children: [
          ListTile(
            title: Text('Pesquisa'),
            onTap: () {
              BlocProvider.of<DogBloc>(context).add(LoadDogEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Search()),
              );
            },
          ),
          ListTile(
            title: Text('Downloads'),
            onTap: () {
              BlocProvider.of<DogBloc>(context).add(DownloadInitialEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Downloads()),
              );
            },
          ),
        ],
      ),
    );
  }
}
