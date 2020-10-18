import 'package:flutter/material.dart';

import '../main.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;

  ProductDetails(
  {this.product_detail_name,
  this.product_detail_new_price,
    this.product_detail_old_price,
    this.product_detail_picture
  }
      );

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text("ShopSolutions")),
        actions: [
          IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: () {}),

        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture,
                ),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(widget.product_detail_name,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text('\$${widget.product_detail_old_price}',
                      style: TextStyle(
                          color: Colors.grey,decoration: TextDecoration.lineThrough)
                        ),
                      ),
                      Expanded(
                        child: Text('\$${widget.product_detail_new_price}',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(onPressed: () {
                  showDialog(context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Size'),
                      content: Text('Choose the size'),
                      actions: [
                        MaterialButton(onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                        child: Text('close'),
                        )
                      ],
                    );
                  }
                  );
                },
                color: Colors.white,
                textColor: Colors.grey,
                  elevation: 0.2,
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Size'),
                    ),
                    Expanded(
                      child: Icon(Icons.arrow_drop_down),

                    )
                  ],
                ),
                ),
              ),

              Expanded(
                child: MaterialButton(onPressed: () {
                  showDialog(context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Colors'),
                          content: Text('Choose the color'),
                          actions: [
                            MaterialButton(onPressed: () {
                              Navigator.of(context).pop(context);
                            },
                              child: Text('close'),
                            )
                          ],
                        );
                      }
                  );
                },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Colors'),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),

                      )
                    ],
                  ),
                ),
              ),

              Expanded(
                child: MaterialButton(onPressed: () {
                  showDialog(context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Quantity'),
                          content: Text('Choose the quantity'),
                          actions: [
                            MaterialButton(onPressed: () {
                              Navigator.of(context).pop(context);
                            },
                              child: Text('close'),
                            )
                          ],
                        );
                      }
                  );
                },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Qty'),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),

                      )
                    ],
                  ),
                ),
              )
            ],
          ),


          Row(
            children: [
              Expanded(
                child: MaterialButton(onPressed: () {},
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text('Buy now'),
                ),
              ),
              IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () {}),
              IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {}),

            ],
          ),
          Divider(),
          ListTile(
            title: Text('Product details'),
            subtitle: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.'),
          ),
          Divider(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text('Product name',style: TextStyle(color: Colors.grey),),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.product_detail_name),
              )
            ],
          ),

          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text('Product brand',style: TextStyle(color: Colors.grey),),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('Brand X'),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text('Product condition',style: TextStyle(color: Colors.grey),),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('New'),
              )
            ],
          ),

          Divider(),

          Text("Similar Products"),

          Container(
            height: 360,
            child: Similar_Products(),
          )
        ],
      ),
    );
  }
}

class Similar_Products extends StatefulWidget {
  @override
  _Similar_ProductsState createState() => _Similar_ProductsState();
}

class _Similar_ProductsState extends State<Similar_Products> {
  var product_list = [
    {
      "name":"Blazer",
      "picture":"images/products/blazer1.jpeg",
      "old_price":120,
      "price":85
    },

    {
      "name":"Red dress",
      "picture":"images/products/hills1.jpeg",
      "old_price":100,
      "price":50
    },

    {
      "name":"Red dress",
      "picture":"images/products/dress2.jpeg",
      "old_price":100,
      "price":50
    },

  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context,int index) {
        return Similar_single_prod(
          product_name: product_list[index]['name'],
          prod_picture: product_list[index]['picture'],
          prod_old_price: product_list[index]['old_price'],
          prod_price: product_list[index]['price'],
        );
      },
    );
  }
}

class Similar_single_prod extends StatelessWidget {
  final product_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Similar_single_prod({
    this.product_name,
    this.prod_picture,
    this.prod_old_price,
    this.prod_price
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: Text("hero 1"),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetails(product_detail_name: product_name, product_detail_new_price: prod_price,product_detail_old_price: prod_old_price,product_detail_picture: prod_picture,)));
            },
            child: GridTile(
              footer: Container(
                  color: Colors.white70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(product_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                      ),
                      Text("\$${prod_price}",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                    ],
                  )
              ),
              child: Image.asset(prod_picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

