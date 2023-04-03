import 'package:equatable/equatable.dart';
import 'package:flutter_counter/dogapi/model/dog_model.dart';

abstract class DogState extends Equatable {
  @override
  List<Object> get props => [];
}

// data loading state
class DogLoadingState extends DogState {}

// data loaded state
class DogLoadedState extends DogState {

  final List dogs;

  DogLoadedState(this.dogs);

  @override
  List<Object> get props => [dogs];
}

// data error loading state.
class DogErrorState extends DogState {
  DogErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

// -------------------- //
// hive states
// initial
class DownloadInitial extends DogState {}

// loading
class DownloadLoading extends DogState {}

// loaded
class DownloadLoaded extends DogState {
  final List dogs;

  DownloadLoaded(this.dogs);

  @override
  List<Object> get props => [dogs];
}

// catching error
class DownloadErrorState extends DogState {
  DownloadErrorState(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}

// show all downloads
class DownloadGetAllState extends DogState {
  final List dogs;

  DownloadGetAllState({required this.dogs});
}

// add download
class DownloadAddState extends DogState {}

// display all datas
class DisplayAllDatas extends DogState {
  final List<DogModel> dogs;
  DisplayAllDatas({required this.dogs});
  @override
  List<Object> get props => [dogs];
}

// mostra a lista de requisicoes
class DisplayAllRequests extends DogState {
  final List<DogModel> dogs;
  DisplayAllRequests({required this.dogs});
  @override
  List<Object> get props => [dogs];
}