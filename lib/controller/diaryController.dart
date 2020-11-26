// import 'package:flutter/foundation.dart';
import '../models/entry.dart';
import '../helpers/db_helper.dart';

class Controller {
  Controller controller;

  Controller() {
    if (controller == null) {
      controller = Controller();
    }
    // return controller;
  }

  static void addEntry(Entry newEntry) {
    // Entry diaryEntry = Entry(
    //     entryId: DateTime.now().toString(),
    //     entryDate: entryDate,
    //     entryText: entryText);
    print(newEntry);
    DBHelper.addEntry(data: newEntry.toMap()
        // {
        //   'id': diaryEntry.entryId,
        //   'entry_text': diaryEntry.entryText,
        //   'entry_date': diaryEntry.entryDate,
        // }
        );
  }

  static Future<List<Entry>> getEntries() async {
    final List<Map<String, dynamic>> maps = await DBHelper.getEntries();
    final List<Entry> entries = List.generate(maps.length, (i) {
      return Entry(
          entryId: maps[i]['id'],
          entryText: maps[i]['entry_text'],
          entryDate: maps[i]['entry_date']);
    });
    print(entries);
    return entries;
  }

  static void deleteEntry() {}
}