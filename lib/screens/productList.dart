import 'package:estore_flutter/db/dbHelper.dart';
import 'package:estore_flutter/models/product.dart';
import 'package:estore_flutter/screens/productDetail.dart';
import 'package:flutter/material.dart';

import 'addProduct.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductListState();
  }
}

class ProductListState extends State<ProductList> {
  DbHelper helper = DbHelper();
  List<Product> products = [];
  int countOfProduct = 0;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      getProducts();
    }
    return Scaffold(
      body: productList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add new product",
        onPressed: (){
          navigateToAddProduct();
        },
      ),
    );
  }

  ListView productList() {
    return ListView.builder(
        itemCount: countOfProduct,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.grey,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Text("ES"),
              ),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: () {
                navigateToDetail(this.products[position]);
              },
            ),
          );
        });
  }

  void getProducts() {
    var dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      var productsFuture = helper.getProducts();
      productsFuture.then((data) {
        print(data);
        List<Product> productsData = [];
        int count = data.length;
        for (int i = 0; i < count; i++) {
          productsData.add(Product.fromObject(data[i]));
        }
        setState(() {
          products = productsData;
          countOfProduct = count;
        });
      });
    });
  }

  void navigateToDetail(Product product) async{
    bool sonuc = Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product))) as bool;
    if(sonuc != null){
      if(sonuc){
        getProducts();
      }
    }
  }
  void navigateToAddProduct() async{
    bool sonuc = Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct())) as bool;
    if(sonuc != null){
      if(sonuc){
        getProducts();
      }
    }
  }
}