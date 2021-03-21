import 'package:flutter/material.dart';
import 'package:shopsolutions/components/cart_products.dart';


class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),

      body: CartProducts(),

      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text('Total:'),
                subtitle: Text('\$230'),
              ),
            ),

            Expanded(
              child: MaterialButton(
                  child: Text('Check out',style: TextStyle(
                    color: Colors.white
                  ),),
                  color: Colors.red,
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
