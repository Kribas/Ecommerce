import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {

  var products_on_the_cart = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1
    },
    {
      "name": "Shoes",
      "picture": "images/products/hills1.jpeg",
      "price": 50,
      "size": "7",
      "color": "Red",
      "quantity": 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: products_on_the_cart[index]['name'],
            cart_prod_picture: products_on_the_cart[index]['picture'],
            cart_prod_price: products_on_the_cart[index]['price'],
            cart_prod_size: products_on_the_cart[index]['size'],
            cart_prod_color: products_on_the_cart[index]['color'],
            cart_prod_qty: products_on_the_cart[index]['quantity'],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {

  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_qty
  });



  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cart_prod_name),
        subtitle: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(cart_prod_size),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0,8.0,8.0,8.0),
                  child: Text("Color:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cart_prod_color),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

