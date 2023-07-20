import 'package:get/get.dart';

class ChatController extends GetxController {

  RxList<int> list = <int>[].obs;

  get dataList => list.reversed;


  void addDataInToList(){
    for (var i = 0; i < 55; i++) {
      list.add(i);
    notifyChildrens();
    }
  }
}
