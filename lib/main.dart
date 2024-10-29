import 'package:estore_flutter/db/dbHelper.dart';
import 'package:estore_flutter/screens/productList.dart';
import 'package:flutter/material.dart';
import 'models/product.dart';

void main() {
  runApp(HomePage(

  ));
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: "E-Store",
     home: EStore(),
    );
  }

}
class EStore extends StatefulWidget{ // data varsa stateful
  @override
  State<StatefulWidget> createState() {
    return EStoreState();
  }
}

class EStoreState extends State<EStore> {
  @override
  Widget build(BuildContext context) {
    /*
   DbHelper helper =  DbHelper();
    helper.initializeDb().then((database) => {});

    Product product1 =  Product("55 inç TV", "LCD Television", 30000);
    Product product2 =  Product("45 inç TV", "HD Television", 20000);
    Product product3 =  Product("35 inç TV", "Ultra HD Television", 40000);
    helper.insert(product1);
    helper.insert(product2);
    helper.insert(product3);
*/
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Store"),
      ),
      body: ProductList (),
    );
  }

}

