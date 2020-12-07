// import 'package:flutter/foundation.dart';

import '../entities/entryEntity.dart';
import '../db_helper.dart';

class EntryModel {
  DBHelper _dbHelper = DBHelper.instance;

  Future<void> addEntry(Entry entry) async {
    await _dbHelper.addEntry(data: entry.toMap());
  }

  Future<void> deleteEntry(Entry entry) async {
    await _dbHelper.deleteEntry(id: entry.entryId);
  }

  Future<List<Entry>> getEntries() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.getEntries();
    final List<Entry> entries = List.generate(maps.length, (i) {
      return Entry.fromMap(maps[i]);
      // entryId: maps[i]['id'],
      // entryText: maps[i]['entry_text'],
      // entryDate: DateTime.parse(maps[i]['entry_date'].toString()));
    });
    return entries;
  }

  Future<dynamic> getEntryById(String id) async {
    var entry = await _dbHelper.getEntryById(id);
    if (entry is Map<String, dynamic>) return Entry.fromMap(entry);
    return entry;
    // Map<String, dynamic> entryMap = await _dbHelper.getEntryById(id);
    // return Entry.fromMap(entryMap);
  }

  Future<void> update(Entry entry) async {
    Map<String, dynamic> entryMap = entry.toMap();
    var result = await _dbHelper.update(entryMap);
    print(result);
  }
}
