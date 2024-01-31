part of 'list_bloc_page.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  late List<MyItem> dataList;

  MyBloc() : super(MyInitialState()) {
    on<InitialEvent>(InitialEventMethod);
    on<LoadDataEvent>(LoadDataEventMethod);
    on<AddItemEvent>(AddItemEventMethod);
    on<UpdateItemEvent>(UpdateItemEventMethod);
    on<DeleteItemEvent>(DeleteItemEventMethod);
  }

  FutureOr<void> LoadDataEventMethod(
      LoadDataEvent event, Emitter<MyState> emit) {
    emit(MyLoadingState());
    final data = <MyItem>[];
    for (var element in [1, 2, 3, 4, 5]) {
      data.add(MyItem(
          id: element,
          name: "ANNA - $element",
          description:
              "Anna had $element pets in $element -th of her house while adapting ${element + 1}'s pet"));
    }
    dataList = data;
    emit(MyDataLoadedState(dataList));
  }

  FutureOr<void> AddItemEventMethod(AddItemEvent event, Emitter<MyState> emit) {
    dataList.add(event.newItem);
    emit(MyDataLoadedState(dataList));
  }

  FutureOr<void> DeleteItemEventMethod(
      DeleteItemEvent event, Emitter<MyState> emit) {
    dataList.remove(event.itemToDelete);
    emit(MyDataLoadedState(dataList));
  }

  FutureOr<void> UpdateItemEventMethod(
      UpdateItemEvent event, Emitter<MyState> emit) {
    int index =
        dataList.indexWhere((element) => element.id == event.updatedItem.id);
    dataList[index] = event.updatedItem;
    emit(MyDataLoadedState(dataList));
  }

  FutureOr<void> InitialEventMethod(
      InitialEvent event, Emitter<MyState> emit) {}
}
