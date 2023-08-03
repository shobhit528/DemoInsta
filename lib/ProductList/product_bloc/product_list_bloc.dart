import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListbloc extends Bloc<ProductEvent, ProductState> {
  ProductListbloc() : super(ProductInitial()) {
    on<ProductInitialEvent>(methodProductInitialEvent);
    on<LogoutClickEvent>(methodLogoutClickEvent);
    on<FollowClickEvent>(methodFollowClickEvent);
    on<MessageClickEvent>(methodMessageClickEvent);
    on<PhotosClickEvent>(methodPhotosClickEvent);
    on<VideosClickEvent>(methodVideosClickEvent);
    on<FollowerClickEvent>(methodFollowerClickEvent);
    on<FollowingClickEvent>(methodFollowingClickEvent);
    on<HighlightsClickEvent>(methodHighlightsClickEvent);
    on<AddHighlightsClickEvent>(methodAddHighlightsClickEvent);
  }

  FutureOr<void> methodLogoutClickEvent(
      LogoutClickEvent event, Emitter<ProductState> emit) {
    print("LogoutClicked");
    emit(ProductLogoutNavigateState());
  }

  FutureOr<void> methodHighlightsClickEvent(
      HighlightsClickEvent event, Emitter<ProductState> emit) {}

  FutureOr<void> methodFollowingClickEvent(
      FollowingClickEvent event, Emitter<ProductState> emit) {
    print("FollowingClicked");
  }

  FutureOr<void> methodFollowerClickEvent(
      FollowerClickEvent event, Emitter<ProductState> emit) {
    print("FollowerClicked");
  }

  FutureOr<void> methodFollowClickEvent(
      FollowClickEvent event, Emitter<ProductState> emit) {
    print("FollowClicked");
    emit(ProductFollowNavigateState());
  }

  FutureOr<void> methodVideosClickEvent(
      VideosClickEvent event, Emitter<ProductState> emit) {
    print("VideosClicked");
  }

  FutureOr<void> methodMessageClickEvent(
      MessageClickEvent event, Emitter<ProductState> emit) {
    print("MessageClicked");
    emit(ProductMessageNavigateState());
  }

  FutureOr<void> methodPhotosClickEvent(
      PhotosClickEvent event, Emitter<ProductState> emit) {
    print("PhotosClicked");
  }

  FutureOr<void> methodAddHighlightsClickEvent(
      AddHighlightsClickEvent event, Emitter<ProductState> emit) {
    print("AddhighlightClicked");
  }

  Future<FutureOr<void>> methodProductInitialEvent(
      ProductInitialEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());

    await Future.delayed(const Duration(seconds: 2));
    emit(ProductLoadSuccessState());
  }
}
