import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_node_api/bloc/cart/cart_event.dart';
import 'package:shoe_node_api/bloc/cart/cart_state.dart';
import 'package:shoe_node_api/repository/cart_repo.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo cartRepo;

  CartBloc({@required this.cartRepo})
      : assert(cartRepo != null),
        super(CartLoading());

  @override
  Stream<CartState> mapEventToState(event) async* {
    if (event is CartLoad) {
      yield* mapStateToCartLoadEvent(event);
    } else if (event is CreateCart) {
      yield* mapStateToCartCreateEvent(event);
    } else if (event is UpdateCart) {
      yield* mapStateToCartUpdateEvent(event);
    } else if (event is DeleteCart) {
      yield* mapStateToCartDeleteEvent(event);
    }
  }

  Stream<CartState> mapStateToCartLoadEvent(CartLoad event) async* {
    yield CartLoading();
    try {
      await cartRepo.getUserCart(event.userid);
      yield CartLoaded();
    } catch (_) {
      yield CartLoadingFailed();
    }
  }

  Stream<CartState> mapStateToCartCreateEvent(
      CreateCart event) async* {
    try {
      await cartRepo.createCart(event.cart);
      yield CartLoading();
      final cart = await cartRepo.getCart();
      yield CartLoaded(cart);
    } catch (_) {
      yield CartLoadingFailed();
    }
  }

  Stream<CartState> mapStateToCartUpdateEvent(
      UpdateCart event) async* {
    try {
      await cartRepo.updateCart((event.cart));
      yield CartLoading();
      final cart = await cartRepo.getCart();
      yield CartLoaded(cart);
    } catch (_) {
      yield CartLoadingFailed();
    }
  }

  Stream<CartState> mapStateToCartDeleteEvent(
      DeleteCart event) async* {
    try {
      await cartRepo.deleteCart(event.cart.id);
      yield CartLoading();
      final cart = await cartRepo.getUserCart(event.cart.userid);
      yield CartLoaded();
    } catch (_) {
      yield CartLoadingFailed();
    }
  }
}
