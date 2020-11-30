// import 'package:flutter/foundation.dart';
// import 'dart:collection';
import '../models/entities/entryEntity.dart';
import '../models/models/entryModel.dart';
import '../view/constants/controllerFunctionNames.dart';

class Controller {
  static Controller _controllerInstance;
  EntryModel model = EntryModel();

  static get instance {
    if (_controllerInstance == null) {
      _controllerInstance = Controller._internal();
    }
    return _controllerInstance;
  }

  Controller._internal();

  // dynamic callWithoutAsync(DiaryControllerFunctions function,[]){}

  Future<dynamic> callAsync(
      {DiaryControllerAsyncFunctions function,
      Entry addEntryEntry,
      Entry deleteEntryEntry}) async {
    try {
      switch (function) {
        case DiaryControllerAsyncFunctions.addEntry:
          await _addEntry(addEntryEntry);
          return;
        case DiaryControllerAsyncFunctions.deleteEntry:
          await _deleteEntry(deleteEntryEntry);
          return;
        case DiaryControllerAsyncFunctions.getEntries:
          List<Entry> entries = await _getEntries();
          if (entries.isEmpty) return [];
          return entries;
      }
    } catch (error) {
      print("Error in asyncCall " + error.toString());
    }
  }

  Future<void> _addEntry(Entry entry) async {
    await model.addEntry(entry);
  }

  Future<List<Entry>> _getEntries() async {
    return model.getEntries();
  }

  Future<void> _deleteEntry(Entry entry) async {
    await model.deleteEntry(entry);
  }
}
