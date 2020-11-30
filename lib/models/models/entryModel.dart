// import 'package:flutter/foundation.dart';

import '../entities/entryEntity.dart';
import '../db_helper.dart';

class EntryModel {
  DBHelper dbHelper = DBHelper.instance;

  Future<void> addEntry(Entry entry) async {
    await dbHelper.addEntry(data: entry.toMap());
  }

  Future<void> deleteEntry(Entry entry) async {
    await dbHelper.deleteEntry(id: entry.entryId);
  }

  Future<List<Entry>> getEntries() async {
    final List<Map<String, dynamic>> maps = await dbHelper.getEntries();
    final List<Entry> entries = List.generate(maps.length, (i) {
      return Entry(
          entryId: maps[i]['id'],
          entryText: maps[i]['entry_text'],
          entryDate: DateTime.parse(maps[i]['entry_date'].toString()));
    });
    return entries;
  }
}
