import 'package:gym_buddy/models/dropdown_item.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {

  static Future<sql.Database> database() async {

    final dbPath = await sql.getDatabasesPath();
    // sql.deleteDatabase(path.join(dbPath, 'gym_buddy.db'));
    return await sql.openDatabase(path.join(dbPath, 'gym_buddy.db'),
        onCreate: (db, version) => _createDb(db), version: 1);
  }

  static void _createDb(sql.Database db) {
    db.execute('CREATE TABLE muscle_groups(group_id TEXT PRIMARY KEY, name TEXT)');
    db.execute('CREATE TABLE exercises(id TEXT PRIMARY KEY, name TEXT, desc TEXT, FK_muscle_group TEXT,'
        'FOREIGN KEY (FK_muscle_group) REFERENCES muscle_groups (group_id))');

    var newGroup = {

      'group_id' : DateTime.now().toString(),
      'name' : 'Group Day 1'

    };

    db.insert('muscle_groups', newGroup);

    var value = {
      'id': DateTime.now().toString(),
      'name': 'Biceps 1',
      'desc': 'Basic biceps exercise usig weight',
      'FK_muscle_group': newGroup['group_id']
    };

    db.insert('exercises', value);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<int?> getNumberOfItems(String table)  async {
    int? count = 0;
    final db = await DBHelper.database();

    final list = await db.rawQuery('SELECT COUNT(*) FROM ' + table);
    count = sql.Sqflite.firstIntValue(list);




    return count;
  }

  static Future<List<Map<String, dynamic>>> fetchData(String table) async {

    final db = await DBHelper.database();

    return db.query(table);
  }

  static Future<List<Object?>> fetchDropDownItems(String table, whereArg) async {

    final db = await DBHelper.database();

    final results = db.query(table, columns: ['id' 'name' 'desc' 'FK_muscle_group'], where: 'FK_muscle_group = ?', whereArgs: [whereArg]);

    return results;
  }

}