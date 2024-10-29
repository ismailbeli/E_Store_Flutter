import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:estore_flutter/models/product.dart';

class DbHelper {
  String tblProduct = "Products";
  String colId = "Id";
  String colName = "Name";
  String colDescription = "Description";
  String colPrice = "Price";

  // Singleton design pattern
  DbHelper._internal();
  static final DbHelper _dbHelper = DbHelper._internal();
  factory DbHelper() {
    return _dbHelper;
  }

  // Access to the database
  static Database? _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db!;
  }

  // Create the database
  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "estore.db";
    var dbEstore = await openDatabase(path, version: 1, onCreate: createDb);
    return dbEstore;
  }

  // Create the table
  void createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tblProduct($colId INTEGER PRIMARY KEY, $colName TEXT, " +
            "$colDescription TEXT, $colPrice REAL)");
  }

  // Insert a product
  Future<int> insert(Product product) async {
    Database db = await this.db;
    var result = await db.insert(tblProduct, product.createMap());
    return result;
  }

  // Update a product
  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update(tblProduct, product.createMap(),
        where: "$colId = ?", whereArgs: [product.id]);
    return result;
  }

  // Delete a product
  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM $tblProduct WHERE $colId = $id");
    return result;
  }

  // Get products
  Future<List> getProducts() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblProduct");
    return result;
  }
}