import 'package:estore_flutter/db/dbHelper.dart';
import 'package:estore_flutter/screens/productDetail.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProductState();
  }
}

class AddProductState extends State{

  DbHelper helper = DbHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),

      ),
      body: Padding(
          padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
      child: Column(
    children: <Widget>[
      TextField(
        controller: nameController,
        decoration: InputDecoration(labelText: "Product Name"),
      ),      TextField(
        controller: descriptionController,
        decoration: InputDecoration(labelText: "Product Description"),
      ),      TextField(
        controller: priceController,
        decoration: InputDecoration(labelText: "Product Price"),
      ),
    TextButton(
    child: Text("Add Product"),
    onPressed: () {
    AddProduct();
      },
    )
    ],
    )
    )
    );
  }
  Future<void> AddProduct() async {
    int sonuc = await dbHelper.insert(Product(nameController.text, descriptionController.text, double.tryParse(priceController.text) ?? 0.0));
    if (sonuc != 0) {
      Navigator.pop(context, true);
      AlertDialog alertDialog = AlertDialog(
        title: Text("Başarılı"),
        content: Text("${nameController.text} added successfully"),
      );
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }
}