import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/cart_item.dart';

class CartDB {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'cart.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE cart(
          name TEXT PRIMARY KEY,
          image TEXT,
          price REAL,
          quantity INTEGER
        )
        ''');
      },
    );
  }

  static Future<void> insertCart(CartItem item) async {
    final database = await db;
    await database.insert('cart', {
      'name': item.name,
      'image': item.image,
      'price': item.price,
      'quantity': item.quantity,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<CartItem>> getCart() async {
    final database = await db;
    final List<Map<String, dynamic>> maps = await database.query('cart');

    return List.generate(maps.length, (i) {
      return CartItem(
        name: maps[i]['name'],
        image: maps[i]['image'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  static Future<void> deleteCart(String name) async {
    final database = await db;
    await database.delete('cart', where: 'name=?', whereArgs: [name]);
  }

  static Future<void> clearCart() async {
    final database = await db;
    await database.delete('cart');
  }
}
