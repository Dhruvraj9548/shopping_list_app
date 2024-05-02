import 'package:shopping_list_app/shopping_list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static const int _version  = 1;
  static const String _dbName = "Items.db";

  static Future<Database> _getDB() async{
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async =>
        await db.execute("CREATE TABLE Item(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL);"), version: _version
    );
  }

  static Future<int> addItem(Item item)async {
    final db = await _getDB();
    return await db.insert("Item", item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateItem(Item item)async {
    final db = await _getDB();
    return await db.update("Item", item.toJson(),
        where: 'id = ?',
        whereArgs: [item.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteItem(Item item)async{
    final db = await _getDB();
    return await db.delete("Item",
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  static Future<List<Item>?> getAllItems() async{
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query("Item");

    if(maps.isEmpty){
      return null;
    }

    return List.generate(maps.length, (index) => Item.fromJson(maps[index]));
  }




}