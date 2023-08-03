import 'package:chatapp/ProductList/product_bloc/product_list_bloc.dart';
import 'package:chatapp/ProductList/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  final ProductListbloc _listbloc = ProductListbloc();

  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _listbloc.add(ProductInitialEvent());
    return BlocConsumer<ProductListbloc, ProductState>(
        bloc: _listbloc,
        listenWhen: (previous, current) => current is ProductActionState,
        buildWhen: (previous, current) => current is! ProductActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductLoadingState:
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            case ProductLoadSuccessState:
              return ProductListView(_listbloc);
            case ProductErrorState:
              return const Scaffold(body: Center(child: Text("error")));
          }
          return const SizedBox();
        },
        listener: (context, state) {
          switch (state.runtimeType) {
            case ProductLogoutNavigateState:
              break;

            case ProductFollowNavigateState:
              break;

            case ProductMessageNavigateState:
              break;
            case ProductInitial:
              break;
            case ProductLoadSuccessState:
              break;
          }
        });
  }
}
