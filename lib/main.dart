import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shopsolutions/components/horizontal_list_view.dart';
import 'package:shopsolutions/components/products.dart';
import 'package:shopsolutions/pages/cart.dart';
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    Widget image_coursel = Container(
      height: 200,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          Image.asset('images/c1.jpg'),
          Image.asset('images/m1.jpeg'),
          Image.asset('images/m2.jpg'),
          Image.asset('images/w1.jpeg'),
          Image.asset('images/w3.jpeg'),
          Image.asset('images/w4.jpeg'),
        ],
        autoplay: false,
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('ShopSolutions'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
          },icon: Icon(Icons.shopping_cart),)
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red
              ),
                accountName: Text("Kribas Rimal"),
                accountEmail: Text("kribasrimal180@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/32868850?s=460&u=f2b361ae956461e579db724bffd099a2b5757163&v=4'),
            ),
            ),

            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home,color: Colors.red),
              onTap: () {},
            ),

            ListTile(
              title: Text('My Account'),
              leading: Icon(Icons.person,color: Colors.red),
              onTap: () {},
            ),
            ListTile(
              title: Text('My Orders'),
              leading: Icon(Icons.shopping_bag,color: Colors.red),
              onTap: () {},
            ),
            ListTile(
              title: Text('Shopping Cart'),
              leading: Icon(Icons.shopping_cart,color: Colors.red,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
              },
            ),
            ListTile(
              title: Text('Favourites'),
              leading: Icon(Icons.favorite,color: Colors.red),
              onTap: () {},
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings,),
              onTap: () {},
            ),
            ListTile(
              title: Text('About'),
              leading: Icon(Icons.help,),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          //image carousel
          image_coursel,

          Padding(padding: EdgeInsets.all(2.0),
          child: Text('Categories'),
          ),

          //Horizontal ListView
          HorizontalListView(),

          Padding(padding: EdgeInsets.all(20.0),
            child: Text('Recent Products'),
          ),

          //gridView
          Container(
            height: 320,
            child: Products(),
          )

        ],
      ),
    );
  }
}


