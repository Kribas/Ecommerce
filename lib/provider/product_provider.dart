import 'package:shopsolutions/models/product.dart';
import 'package:shopsolutions/services/products.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  ProductService _productServices = ProductService();
  List<ProductModel> products = [];
  List<ProductModel> productsSearched = [];


  ProductProvider.initialize(){
    loadProducts();
  }

  loadProducts()async{
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future search({String productName})async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }

}