import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shoe_node_api/Screen/utils/constants.dart';
import 'package:shoe_node_api/bloc/cart/cart_bloc.dart';
import 'package:shoe_node_api/bloc/cart/cart_event.dart';
import 'package:shoe_node_api/bloc/cart/cart_state.dart';
import 'package:shoe_node_api/data_provider/cart_data_provider.dart';
import 'package:shoe_node_api/repository/cart_repo.dart';

class Cart extends StatelessWidget {
  final CartRepo cartRepo = CartRepo(
      cartDataProvider: CartDataProvider(httpClient: Client()));
  final String userid;

   Cart({Key key, this.userid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.kPrimaryColor,
        title: Row(children: [Icon(Icons.shopping_cart),Text("Cart")]),
      ),
      body:BlocProvider(
        create:
              (context) =>
            CartBloc(cartRepo: this.cartRepo)..add(CartLoad(userid)),
            
            child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              final cartitems = state.cartItems;
              return RefreshIndicator(
                onRefresh:()async{
                    return await context.read<CartBloc>().add(CartLoad(userid));
                } ,
                child: ListView.builder(
                    
                    itemCount: cartitems.length,
                    itemBuilder: (context, index) {
                        
                    }));
            },
            ) 
        
        
    ));
  }
}