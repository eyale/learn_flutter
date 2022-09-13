import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
// import 'package:sqflite/sqflite.dart';

enum DBTables {
  userPlaces,
}

class DBHelper {
  static Future<sql.Database> getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    // await sql.deleteDatabase(path.join(dbPath, 'places.db'));
    final sqlDB = await sql.openDatabase(
      version: 1,
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE userPlaces(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REA, address TEXT)');
      },
    );
    return sqlDB;
  }

  static Future<void> insert({
    required String tableName,
    required Map<String, Object> data,
  }) async {
    final db = await getDatabase();

    await db.insert(
      tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object?>>> getData({
    required String tableName,
  }) async {
    final db = await getDatabase();
    return db.query(tableName);
  }
}
