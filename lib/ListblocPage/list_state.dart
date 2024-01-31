part of 'list_bloc_page.dart';
abstract class MyState {
  const MyState();

  @override
  List<Object> get props => [];
}

class MyInitialState extends MyState {
  @override
  String toString() => 'MyInitialState';
}

class MyLoadingState extends MyState {
  @override
  String toString() => 'MyLoadingState';
}

class MyDataLoadedState extends MyState {
  final List<MyItem> data;

  MyDataLoadedState(this.data);
  @override
  List<Object> get props => [data];

  @override
  String toString() =>"MyDataLoadedState";

}

class MyErrorState extends MyState {
  final String error;

  const MyErrorState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MyErrorState { error: $error }';
}

class MyDummyState extends MyState{

  const MyDummyState();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'MyDummyState';
}