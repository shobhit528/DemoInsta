part of 'product_list_bloc.dart';

abstract class ProductState {}

abstract class ProductActionState extends ProductState {}

class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadSuccessState extends ProductState {

}

class ProductErrorState extends ProductState {}

class ProductLogoutNavigateState extends ProductActionState {}

class ProductFollowNavigateState extends ProductActionState {}

class ProductMessageNavigateState extends ProductActionState {}
