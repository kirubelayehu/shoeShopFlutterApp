import 'package:equatable/equatable.dart';
import 'package:shoe_node_api/model/cart.dart';
// import 'package:shoe_node_api/Screen/User/pages/cart.dart';


class CartState extends Equatable {
  CartState();
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Cart> cart;

  CartLoaded([this.cart=const []]);
  @override
  List<Object> get props => [];
}
class CartLoadingFailed extends CartState{

}