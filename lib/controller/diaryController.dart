import 'package:flutter/foundation.dart';
// import 'dart:collection';
import '../models/entities/entryEntity.dart';
import '../models/models/entryModel.dart';
import '../view/models/entryViewModel.dart';
import '../view/constants/controllerFunctionNames.dart';

class Controller {
  static Controller _controllerInstance;
  EntryModel model = EntryModel();

  static const ADD_ENTRY_ASYNC_FUNCTION = "addEntry";
  static const DELETE_ENTRY_ASYNC_FUNCTION = "deleteEntry";
  static const UPDATE_ENTRY_ASYNC_FUNCTION = "updateEntry";
  static const GET_ENTRIES_ASYNC_FUNCTION = "getEntries";
  static const GET_ENTRY_BY_ID_ASYNC_FUNCTION = "getEntryById";

  static get instance {
    if (_controllerInstance == null) {
      _controllerInstance = Controller._internal();
    }
    return _controllerInstance;
  }

  Controller._internal();

  // dynamic callWithoutAsync(DiaryControllerFunctions function,[]){}

  Future<dynamic> callAsync(
      {@required String functionName,
      EntryViewModel addEntry_entry,
      EntryViewModel deleteEntry_entry,
      EntryViewModel updateEntry_entry,
      String getEntryById_id}) async {
    try {
      switch (functionName) {
        case ADD_ENTRY_ASYNC_FUNCTION:
          return (await _addEntry(addEntry_entry));
        case DELETE_ENTRY_ASYNC_FUNCTION:
          return (await _deleteEntry(deleteEntry_entry));
        case GET_ENTRIES_ASYNC_FUNCTION:
          return await _getEntries();
        case GET_ENTRY_BY_ID_ASYNC_FUNCTION:
          return (await _getEntryById(getEntryById_id));
        case UPDATE_ENTRY_ASYNC_FUNCTION:
          return (await _updateEntry(updateEntry_entry));
      }
    } catch (error) {
      print("Error in DiaryController asyncCall " + error.toString());
    }
  }

  Future<void> _addEntry(EntryViewModel entry) async {
    await model.addEntry(Entry.fromViewModel(entry));
  }

  Future<List<EntryViewModel>> _getEntries() async {
    List<Entry> entries = await model.getEntries();
    if (entries.isEmpty) return [];
    final List<EntryViewModel> entriesVM = List.generate(entries.length, (i) {
      return EntryViewModel.fromEntity(entries[i]);
    });
    return entriesVM;
  }

  Future<void> _deleteEntry(EntryViewModel entry) async {
    await model.deleteEntry(Entry.fromViewModel(entry));
  }

  Future<EntryViewModel> _getEntryById(String id) async {
    return EntryViewModel.fromEntity(await model.getEntryById(id));
  }

  Future<void> _updateEntry(EntryViewModel entry) async {
    await model.update(Entry.fromViewModel(entry));
  }
}
