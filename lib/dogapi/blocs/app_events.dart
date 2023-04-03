import 'package:equatable/equatable.dart';
import 'package:flutter_counter/dogapi/model/dog_model.dart';

// searched dogs
abstract class DogEvent extends Equatable {
  const DogEvent();
  @override
  List<DogModel> get props => [];
}

// load event
class LoadDogEvent extends DogEvent {}

// --------------------------
// download dogs events

// initial events
class DownloadInitialEvent extends DogEvent {}

class DogInitialEvent extends DogEvent {}

// add Download
class DownloadAddOneEvent extends DogEvent {
  final int index;

  DownloadAddOneEvent({required this.index});
}

// add all
class DownloadAddAllEvent extends DogEvent {}

// delete event
class DownloadDeleteEvent extends DogEvent {
  final int index;

  DownloadDeleteEvent({required this.index});
}

// deletar todos
class DownloadDeleteAllEvent extends DogEvent {
  final List<DogModel> dogs;

  const DownloadDeleteAllEvent({required this.dogs});
}

// pegar todos arquivos baixados
class FetchAllData extends DogEvent {
  const FetchAllData();
}

// pegar todos os arquivos do request
class FetchAllRequests extends DogEvent {
  const FetchAllRequests();
}
