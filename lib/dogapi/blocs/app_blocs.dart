import 'package:bloc/bloc.dart';
import 'package:flutter_counter/dogapi/blocs/app_events.dart';
import 'package:flutter_counter/dogapi/blocs/app_states.dart';
import 'package:flutter_counter/dogapi/model/dog_model.dart';
import 'package:hive/hive.dart';

import '../../data/boxes.dart';
import '../../data/database.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  List<DogModel> _dogs = [];

  DogBloc() : super(DogLoadingState()) {
    Box<DogModel> boxSavedDogs;
    List<DogModel> savedDogsList;

    on<LoadDogEvent>((event, emit) async {
      try {
        emit(DogLoadingState());
        if (_dogs.isEmpty) {
          throw new Exception();
        } else {
          emit(DogLoadedState(_dogs));
        }
      } catch (e) {
        print(e);
        emit(DogErrorState(e.toString()));
      }
    });

    // evento inicial da aba de downloads
    on<DownloadInitialEvent>((event, emit) async {
      try {
        emit(DogLoadingState());

        emit(DownloadLoaded(_dogs));
      } catch (e) {
        emit(DownloadErrorState(e.toString()));
      }
    });

    // evento inicial da aba de requests
    on<DogInitialEvent>((event, emit) async {
      emit(DogLoadingState());
      try {
        final List<DogModel> dogs = await DogDatabase.groupDogs(3);
        _dogs = dogs;
        if (_dogs.isEmpty) {
          throw new Exception();
        }
        emit(DogLoadedState(_dogs));
      } catch (e) {
        print(e);
        emit(DogErrorState(e.toString()));
      }
    });

    // pegar todos os dados baixados
    on<FetchAllData>((event, emit) {
      try {
        boxSavedDogs = Boxes.getDogsFromBox();
        savedDogsList = boxSavedDogs.values.toList();
        emit(DisplayAllDatas(dogs: savedDogsList));
      } catch (e) {
        print('$e');
      }
    });

    // pegar todos os requestes
    on<FetchAllRequests>((event, emit) {
      try {
        emit(DisplayAllRequests(dogs: _dogs));
      } catch (e) {
        print('$e');
      }
    });

    // adicionar um cachorro
    on<DownloadAddOneEvent>((event, emit) async {
      try {
        final box = Boxes.getDogsFromBox();
        box.add(_dogs[event.index]);
        add(const FetchAllData());
      } catch (e) {
        emit(DownloadErrorState(e.toString()));
      }
    });

    // adicionar todos os cachorros
    on<DownloadAddAllEvent>((event, emit) async {
      try {
        final box = Boxes.getDogsFromBox();
        box.addAll(_dogs);
        add(const FetchAllData());
      } catch (e) {
        emit(DownloadErrorState(e.toString()));
      }
    });

    // deletar todos os dados
    on<DownloadDeleteAllEvent>((event, emit) async {
      try {
        final box = Boxes.getDogsFromBox();
        await box.clear();
        add(const FetchAllData());
      } catch (e) {
        print('$e');
      }
    });

    // deletar um cachorro
    on<DownloadDeleteEvent>((event, emit) async {
      try {
        final box = Boxes.getDogsFromBox();
        await box.deleteAt(event.index);
        add(const FetchAllData());
      } catch (e) {
        print('$e');
      }
    });
  }
}
