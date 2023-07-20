import 'package:chatapp/ChatScreen/ChatController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Get_IT.dart';
import 'ChatView.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5),(){
      getIt<ChatController>().addDataInToList();
    });
    return const ChatView();
  }
}
