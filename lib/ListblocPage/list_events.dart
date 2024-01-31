part of 'list_bloc_page.dart';
abstract class MyEvent extends Equatable {
  const MyEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends MyEvent {}

class LoadDataEvent extends MyEvent {
  @override
  String toString() => 'LoadDataEvent';
}

class AddItemEvent extends MyEvent {
  final MyItem newItem;
  AddItemEvent(this.newItem);

  @override
  List<Object> get props => [newItem];

  @override
  String toString() => 'AddItemEvent { newItem: $newItem }';
}

class UpdateItemEvent extends MyEvent {
  final MyItem updatedItem;

  const UpdateItemEvent(this.updatedItem);

  @override
  List<Object> get props => [updatedItem];

  @override
  String toString() => 'UpdateItemEvent { updatedItem: $updatedItem }';
}

class DeleteItemEvent extends MyEvent {
  final MyItem itemToDelete;

  const DeleteItemEvent(this.itemToDelete);

  @override
  List<Object> get props => [itemToDelete];

  @override
  String toString() => 'DeleteItemEvent { itemToDelete: $itemToDelete }';
}

