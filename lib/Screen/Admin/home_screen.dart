import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shoe_node_api/Screen/Admin/add_product.dart';
import 'package:shoe_node_api/Screen/Admin/productDetail.dart';
import 'package:shoe_node_api/Screen/route.dart';
import 'package:shoe_node_api/Screen/utils/constants.dart';
import 'package:shoe_node_api/bloc/product/product_bloc.dart';
import 'package:shoe_node_api/bloc/product/product_event.dart';
import 'package:shoe_node_api/bloc/product/product_state.dart'te.dart';
import 'package:shoe_node_api/data_provider/product_provider.dart';
import 'package:shoe_node_api/repository/product_repo.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = '/adminHome';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductRepo productRepo = ProductRepo(
      productDataProvider: ProductDataProvider(httpClient: Client()));
 
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
              create: (context) =>
            ProductBloc(productRepo: this.productRepo)..add(ProductLoad()),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Products"),
            actions: <Widget>[
              IconButton(

                icon: Icon(Icons.shopping_cart),
                onPressed: ()=>Navigator.pushNamed(context, '/cart'),
              )
            ],
          ),
          body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductLoadingFailed) {
              return Center(
                  child: Text("Product Loading Failed",
                      style: Constant.boldHeading));
            }
            
            if (state is ProductLoaded) {
            final products = state.product;
              // print("Products : $products");
              if (products.length == 0) {
                return Center(
                  
                  child: Column(
                    children: [
                         Text("No Product Available For Now",
                        style: Constant.boldHeading),
                      IconButton(
                        icon: Icon(Icons.leaderboard),
                        onPressed: (){
                                   context.read<ProductBloc>()
                                        .add(ProductLoad());
                        },
                      )
                    ],
                   
                  ),
                );
              }
              
              return RefreshIndicator(
                onRefresh:()async{
                    return await context.read<ProductBloc>().add(ProductLoad());
                } ,
                child: ListView.builder(
                    
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                        return Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
                            child: MaterialButton(
                              padding:EdgeInsets.all(0),elevation: 0.5,
                              color: Colors.white,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              onPressed: (){
                                 Navigator.of(context).pushNamed(productDetail.routeName,
                                arguments: products[index]);
                              },
                              child: Row(
                                children: <Widget>[
                                  
                                  Ink(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      'assets/nikeshoes2.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child:Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(products[index].name??"Product Name"),
                                                SizedBox(height: 5),
                                                Text("${products[index].price} Birr")
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon:Icon(Icons.shopping_cart),
                                            onPressed: (){},
                                          )
                                        ],
                                      ),
                                    )
                                  )
                                ],
                              ),
                            ),

                          );                    
                    }),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).pushNamed(
              AddProduct.routeName,
              arguments: ProductArgument(update: false),
            ),
            child: Icon(Icons.add),
          )),
    );
  }
}






                        // GestureDetector(
                        // onTap: () {
                        //   Navigator.of(context).pushNamed(productDetail.routeName,
                        //       arguments: products[index]);
                        // },
                        
                        
                        // child: Container(
                        //   height: 350,
                        //   margin: EdgeInsets.symmetric(
                        //       vertical: 12.0, horizontal: 24.0),
                        //   child: Stack(
                        //     children: [
                        //       Container(
                        //         child: ClipRRect(
                        //           // borderRadius:BorderRadius.circular(15),
                        //           child: Image.asset(
                        //             'assets/nikeshoes2.jpeg',
                        //             fit: BoxFit.cover,
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //           bottom: 0,
                        //           left: 0,
                        //           right: 0,
                        //           child: Padding(
                        //             padding: EdgeInsets.all(20.0),
                        //             child: Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //               children: [
                        //                 Text(
                        //                   products[index].name ?? "Product Name",
                        //                   style: Constant.regularHeading,
                        //                 ),
                        //                 Text(
                        //                   'Birr ${products[index].price ?? "Price"}',
                        //                   style: TextStyle(
                        //                       fontSize: 18.0,
                        //                       color:
                        //                           Theme.of(context).accentColor,
                        //                       fontWeight: FontWeight.w600),
                        //                 )
                        //               ],
                        //             ),
                        //           ))
                        //     ],
                        //   ),
                        // ),
                      // );