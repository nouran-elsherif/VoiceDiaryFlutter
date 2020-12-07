import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

const String ENTRY_TABLE = "diary_entries";

class DBHelper {
  static DBHelper _dbInstance;

  static get instance {
    print('DBHelper Inst.');
    if (_dbInstance == null) {
      _dbInstance = DBHelper._internal();
    }
    return _dbInstance;
  }

  DBHelper._internal();

  Future<sql.Database> _database() async {
    print('DBHelper Inst. _database');
    final dbPath = await sql.getDatabasesPath();
    print('DBHelper Inst. _database $dbPath');
    return sql.openDatabase(path.join(dbPath, 'entries.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE diary_entries(id TEXT PRIMARY KEY, entry_text TEXT, entry_date INTEGER)');
    }, version: 1);
  }

  Future<void> addEntry(
      {String table = ENTRY_TABLE, Map<String, Object> data}) async {
    final db = await _database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getEntries(
      {String table = ENTRY_TABLE}) async {
    final db = await _database();
    return db.query(table, orderBy: "entry_date DESC");
  }

  Future<void> deleteEntry({String table = ENTRY_TABLE, String id}) async {
    // Get a reference to the database.
    final db = await _database();

    await db.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<dynamic> getEntryById(String id) async {
    final db = await _database();
    String sql = 'SELECT * from $ENTRY_TABLE WHERE id = $id';
    // var result = await db.query(ENTRY_TABLE, where: "id = ", whereArgs: [id]);
    var result = await db.rawQuery(sql);
    return result.isNotEmpty ? result.first : Null;
  }

  update(Map<String, dynamic> entry) async {
    final db = await _database();
    var result = await db
        .update(ENTRY_TABLE, entry, where: "id = ?", whereArgs: [entry['id']]);
    return result;
  }
}
