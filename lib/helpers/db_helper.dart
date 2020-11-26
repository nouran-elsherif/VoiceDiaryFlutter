import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

const String ENTRY_TABLE = "diary_entries";

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'entries.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE diary_entries(id TEXT PRIMARY KEY, entry_text TEXT, entry_date TEXT)');
    }, version: 1);
  }

  static Future<void> addEntry(
      {String table = ENTRY_TABLE, Map<String, Object> data}) async {
    final db = await DBHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getEntries(
      {String table = ENTRY_TABLE}) async {
    final db = await DBHelper.database();
    return db.query(table, orderBy: "entry_date DESC");
  }

  static Future<void> deleteEntry(
      {String table = ENTRY_TABLE, String id}) async {
    // Get a reference to the database.
    final db = await DBHelper.database();

    // Remove the Dog from the Database.
    await db.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
