import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maclay_multi_store/provider/cart_provider.dart';
import 'package:maclay_multi_store/views/buyers/inner_screens/checkout_screen.dart';
import 'package:provider/provider.dart';

import '../main_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(
          'Cart Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _cartProvider.removeAllItem();
            },
            icon: Icon(
              CupertinoIcons.delete,
            ),
          ),
        ],
      ),
      body: _cartProvider.getCartItem.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItem.values.toList()[index];
                return Card(
                  child: SizedBox(
                    height: 170,
                    child: Row(children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(cartData.imageUrl[0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartData.productName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5,
                              ),
                            ),
                            Text(
                              '\$' + " " + cartData.price.toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 5,
                                color: Colors.yellow.shade900,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: null,
                              child: Text(
                                cartData.productSize,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 115,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade900,
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: cartData.quantity == 1
                                            ? null
                                            : () {
                                                _cartProvider
                                                    .decreaMent(cartData);
                                              },
                                        icon: Icon(
                                          CupertinoIcons.minus,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        cartData.quantity.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      IconButton(
                                          onPressed: cartData.productQuantity ==
                                                  cartData.quantity
                                              ? null
                                              : () {
                                                  _cartProvider
                                                      .increament(cartData);
                                                },
                                          icon: Icon(
                                            CupertinoIcons.plus,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _cartProvider.removeItem(
                                      cartData.productId,
                                    );
                                  },
                                  icon: Icon(
                                    CupertinoIcons.cart_badge_minus,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Shopping Cart is Empty',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MainScreen();
                      }));
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'CONTINUE SHOPPING',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.totalPrice == 0.00
              ? null
              : () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CheckoutScreen();
                  }));
                },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: _cartProvider.totalPrice == 0.00
                  ? Colors.grey
                  : Colors.yellow.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "\$" +
                    _cartProvider.totalPrice.toStringAsFixed(2) +
                    " " +
                    'CHECKOUT',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 8,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
