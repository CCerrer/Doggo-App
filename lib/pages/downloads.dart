import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter/dogapi/model/dog_model.dart';
import 'package:flutter_counter/pages/navbar.dart';

import '../dogapi/blocs/app_blocs.dart';
import '../dogapi/blocs/app_events.dart';
import '../dogapi/blocs/app_states.dart';

class Downloads extends StatelessWidget {
  const Downloads({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text('Doggo App'),
        actions: [
          BlocBuilder<DogBloc, DogState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  if (state is DisplayAllDatas) {
                    if (state.dogs.isNotEmpty) {
                      context
                          .read<DogBloc>()
                          .add(DownloadDeleteAllEvent(dogs: state.dogs));
                    }
                  }
                },
                child: const Text('Delete all'),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  backgroundColor: Colors.blue,
                ),
              );
            },
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: BlocBuilder<DogBloc, DogState>(
        builder: (context, state) {
          return BlocBuilder<DogBloc, DogState>(builder: (context, state) {
            print(state);
            if (state is DownloadLoaded) {
              context.read<DogBloc>().add(const FetchAllData());
            }
            if (state is DisplayAllDatas) {
              if (state.dogs.isNotEmpty) {
                final List dogsList = state.dogs;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
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
                                  backgroundImage: NetworkImage(
                                      dogsList[index].url.toString()),
                                ),
                                onTap: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    context.read<DogBloc>().add(
                                                        DownloadDeleteEvent(
                                                            index: index));
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: StadiumBorder(),
                                                  ),
                                                  child: Icon(Icons.delete_forever),
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
                          }),
                    )
                  ],
                );
              }
            }
            return Container();
          });
        },
      ),
    );
  }
}
