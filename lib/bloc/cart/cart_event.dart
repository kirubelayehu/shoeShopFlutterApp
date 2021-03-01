import 'package:equatable/equatable.dart';
import 'package:shoe_node_api/model/cart.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class CartLoad extends CartEvent {
  final String userid;

  CartLoad(this.userid);
  // CartLoad();

  @override
  List<Object> get props => [];
}

class CreateCart extends CartEvent {
  final Cart cart;

  const CreateCart(this.cart);

  @override
  List<Object> get props => [cart];

  @override
  String toString() => 'Cart Created {Cart : $cart}';
}

class UpdateCart extends CartEvent {
  final Cart cart;
  const UpdateCart(this.cart);
  @override
  List<Object> get props => [cart];

  @override
  String toString() => 'Cart Updated {Cart : $cart}';
}

class DeleteCart extends CartEvent {
  final Cart cart;

  DeleteCart(this.cart);

  @override
  List<Object> get props => [cart];

  @override
  String toString() => 'Cart Deleted {Cart : $cart}';
}
