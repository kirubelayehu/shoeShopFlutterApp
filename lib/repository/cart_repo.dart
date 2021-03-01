import 'package:flutter/material.dart';
import 'package:shoe_node_api/data_provider/cart_data_provider.dart';
import 'package:shoe_node_api/model/cart.dart';

class CartRepo {
  final CartDataProvider cartDataProvider;

  CartRepo({@required this.cartDataProvider})
      : assert(cartDataProvider != null);

  Future<Cart> createCart(Cart cart) async {
    return await cartDataProvider.createCart(cart);
  }

  Future<List<Cart>> getCart() async {
    return await cartDataProvider.getCart();
  }

  Future<void> getUserCart(String userid) async {
    return await cartDataProvider.getUserCart(userid);
  }

  Future<void> updateCart(Cart cart) async {
    return await cartDataProvider.updateCart(cart);
  }

  Future<void> deleteCart(String id) async {
    return await cartDataProvider.deleteCart(id);
  }
}
