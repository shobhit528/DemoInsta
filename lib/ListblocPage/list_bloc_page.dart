import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../Animations/AnimationClass.dart';

// part of '../UiUtils/BottomTabView.dart';

part 'list_bloc.dart';

part 'list_events.dart';

part 'list_state.dart';

class BlocListPage extends StatelessWidget {
  final _bloc = MyBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.add(LoadDataEvent());
    return Scaffold(
      body: BlocConsumer<MyBloc, MyState>(
        bloc: _bloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case MyDataLoadedState:
              return ListView.builder(
                key: const Key("listKey"),
                shrinkWrap: true,
                itemCount: (state as MyDataLoadedState).data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    key: const Key("itemKey"),
                    onTap: () => _bloc.add(AddItemEvent(MyItem(
                        id: state.data.length,
                        name: "Bella ${state.data.length}",
                        description: ""))),
                    onDoubleTap: () =>
                        _bloc.add(DeleteItemEvent(state.data[index])),
                    onHorizontalDragStart: (details) => _bloc.add(
                        UpdateItemEvent(
                            state.data[index].copyWith(color: Colors.lightBlue))),
                    onHorizontalDragEnd: (details) => _bloc.add(UpdateItemEvent(
                        state.data[index].copyWith(color: Colors.grey))),
                    child: Card(
                      color: state.data[index].color ?? Colors.lightBlue,
                      margin: const EdgeInsets.all(10),
                      child: Stack(
                        fit: StackFit.loose,
                        alignment: Alignment.center,
                        children: [
                          ClipRect(
                          clipBehavior: Clip.hardEdge,
                          child: SizedBox(
                              height: 60,
                              width: Get.width - 20,
                              child: WaveBackground())),
                          ListTile(
                            title: Text(state.data[index].name),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            case MyInitialState:
              return const Center(child: CircularProgressIndicator());
            case MyLoadingState:
              return const Center(child: CircularProgressIndicator());
            case MyErrorState:
              return const Center(child: Text("Something went wrong"));
            default:
              return const Center(child: CircularProgressIndicator());
          }
          return Container();
        },
        buildWhen: (previous, current) =>
            current.runtimeType is! MyLoadingState ,
        listener: (context, state) {
          switch (state.runtimeType) {
            case MyLoadingState:
              break;
            case MyDataLoadedState:
              break;
          }
        },
      ),
    );
  }
}

class MyItem {
  final int id;
  final String name;
  final String description;
  Color? color;

  // Add more properties as needed

  MyItem(
      {required this.id,
      required this.name,
      required this.description,
      this.color = Colors.lightBlue
      // Initialize additional properties here
      });

  copyWith({int? id, String? name, String? description, Color? color}) {
    return MyItem(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        color: color ?? this.color);
  }

// You can add factory methods or other helper methods as needed
}
