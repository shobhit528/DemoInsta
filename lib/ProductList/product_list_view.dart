import 'package:chatapp/Animations/listingAnimation.dart';
import 'package:chatapp/ProductList/product_bloc/product_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListView extends StatelessWidget {
  final ProductListbloc _listbloc;


  ProductListView(this._listbloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListAnimation(),
      ),
    );
  }


}

