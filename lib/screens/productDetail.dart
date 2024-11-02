import 'package:estore_flutter/db/dbHelper.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() {
    return ProductDetailState(product);
  }
}

enum MenuOptions { delete, update }
DbHelper dbHelper = DbHelper();

class ProductDetailState extends State {
  Product product;
  ProductDetailState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product Detail"),
          actions: <Widget>[
            PopupMenuButton<MenuOptions>(
              onSelected:  selectOption,
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<MenuOptions>>[
                      PopupMenuItem<MenuOptions>(
                        value: MenuOptions.delete,
                        child: Text("Delete Product"),
                      ),
                      PopupMenuItem<MenuOptions>(
                        value: MenuOptions.update,
                        child: Text("Update Product"),
                      ),
                    ])
          ],
        ),
        body: Center(
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.shop),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                ),
                Text("Price of ${product.name} : ${product.price}"),
                ButtonBar(children: <Widget>[
                  TextButton(
                    child: Text("Add to Cart"),
                    onPressed: () {
                      AlertDialog alertDialog = AlertDialog(
                        title: Text("Başarılı"),
                        content: Text("${product.name}  added to cart"),
                      );
                      showDialog(context: context, builder: (_) => alertDialog);
                    },
                  )
                ]),
              ],
            ),
          ),
        ));
  }
  void selectOption(MenuOptions option) async {
    int sonuc;
    switch(option){
      case MenuOptions.delete:
        Navigator.pop(context, true); // Go back to the previous screen
        sonuc = dbHelper.delete(product.id!) as int; // Delete the product from the database
        if(sonuc !=0){
          AlertDialog alertDialog = AlertDialog(
            title: Text("Successfull"),
            content: Text("Product deleted"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case MenuOptions.update:
        Navigator.pop(context, true);
        break;
    }
  }
}
