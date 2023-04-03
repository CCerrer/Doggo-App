import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/pages/navbar.dart';

import '../dogapi/blocs/app_blocs.dart';
import '../dogapi/blocs/app_events.dart';
import '../dogapi/blocs/app_states.dart';
import '../dogapi/model/dog_model.dart';
import 'downloads.dart';

class Search extends StatelessWidget {
  Search({super.key});

  List<DogModel> dogsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Doggo App'),
        actions: <Widget>[
          BlocBuilder<DogBloc, DogState>(builder: (context, state) {
            return Row(children: [
              ElevatedButton(
                onPressed: () async {
                  context.read<DogBloc>().add(DogInitialEvent());
                },
                child: const Text('Atualizar'),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Colors.blue),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  context.read<DogBloc>().add(DownloadAddAllEvent());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Downloads()),
                  );
                },
                child: const Text('Baixar'),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Colors.blue,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ]);
          })
        ],
      ),
      body: BlocBuilder<DogBloc, DogState>(
        builder: (context, state) {
          print(state);
          if (state is DogErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.error, size: 100,),
                Text('ERRO DE CONEXÃO')
              ]),
            );
          }
          if (state is DogLoadingState) {
            // context.read<DogBloc>().add(LoadDogEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DogLoadedState) {
            context.read<DogBloc>().add(const FetchAllRequests());
          }
          if (state is DisplayAllRequests) {
            if (state.dogs.isNotEmpty) {
              dogsList = state.dogs;

              return ListView.builder(
                  itemCount: dogsList.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          dogsList[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(dogsList[index].url.toString()),
                        ),
                        onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  Center(
                                      child: Text(
                                    'Raça: ${dogsList[index].name}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    height: 250,
                                    width: 250,
                                    child: Image.network(
                                        dogsList[index].url.toString(),
                                        fit: BoxFit.cover),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<DogBloc>().add(
                                              DownloadAddOneEvent(
                                                  index: index));
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Downloads()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder(),
                                        ),
                                        child: const Text('Download'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
