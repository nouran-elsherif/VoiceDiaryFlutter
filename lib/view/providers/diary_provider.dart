import 'package:flutter/foundation.dart';
import '../../models/entities/entryEntity.dart';
import '../models/entryViewModel.dart';
import '../../controller/diaryController.dart';
import '../constants/controllerFunctionNames.dart';

class DiaryProvider with ChangeNotifier {
  List<EntryViewModel> _entries = [];
  bool _isCurrentlySelected = false;
  String _currentText = '';
  DateTime _currentDate = DateTime.now();
  Controller _diaryController = Controller.instance;

  //async function names
  static const String ADD_ENTRY_ASYNC_FUNCTION = "addEntry";
  static const String DELETE_ENTRY_ASYNC_FUNCTION = "deleteEntry";
  static const String GET_ENTRIES_ASYNC_FUNCTION = "getEntries";
  static const String GET_ENTRY_BY_ID_ASYNC_FUNCTION = "getEntryById";

  //non async function names
  static const String UPDATE_CURRENT_TEXT_FUNCTION = "updateCurrentText";
  static const String UPDATE_CURRENT_DATE_FUNCTION = "updateCurrentDate";
  static const String UPDATE_IS_CURRENTLY_SELECTED_FUNCTION =
      "updateIsCurrentlySelected";

  List<EntryViewModel> get entries {
    return [..._entries];
  }

  String get currentText {
    return _currentText;
  }

  DateTime get currentDate {
    return _currentDate;
  }

  bool get isCurrentlySelected {
    return _isCurrentlySelected;
  }

  dynamic call({
    @required String functionName,
    String updateCurrentText_text,
    DateTime updateCurrentDate_date,
    bool updateIsCurrentlySelected_isSelected,
  }) {
    try {
      switch (functionName) {
        case UPDATE_CURRENT_TEXT_FUNCTION:
          return _updateCurrentText(updateCurrentText_text);
        case UPDATE_CURRENT_DATE_FUNCTION:
          return _updateCurrentDate(updateCurrentDate_date);
        case UPDATE_IS_CURRENTLY_SELECTED_FUNCTION:
          return _updateIsCurrentlySelected(
              updateIsCurrentlySelected_isSelected);
      }
    } catch (error) {
      print("Error in DiaryProvider Call " + error.toString());
    }
  }

  Future<dynamic> callAsync({
    @required String functionName,
    String addEntry_text,
    DateTime addEntry_date,
    int deleteEntry_index,
    String getEntryById_id,
  }) async {
    try {
      switch (functionName) {
        case ADD_ENTRY_ASYNC_FUNCTION:
          return await _addEntry(addEntry_text, addEntry_date);
        case DELETE_ENTRY_ASYNC_FUNCTION:
          return await _deleteEntry(deleteEntry_index);
        case GET_ENTRIES_ASYNC_FUNCTION:
          return await _getEntries();
        case GET_ENTRY_BY_ID_ASYNC_FUNCTION:
          return await _getEntryById(getEntryById_id);
        // case UPDATE_ENTRY_ASYNC_FUNCTION:
        //   return await _updateEntry(updateEntry_entry);
      }
    } catch (error) {
      print("Error in DiaryProvider asyncCall " + error.toString());
    }
  }

  Future<EntryViewModel> _addEntry(String text, DateTime date) async {
    if (date == null) date = DateTime.now();
    final newEntry = EntryViewModel(
        entryId: DateTime.now().millisecondsSinceEpoch.toString(),
        entryText: text,
        entryDate: date);
    //_entries.add(newEntry);
    await _diaryController.callAsync(
        functionName: Controller.ADD_ENTRY_ASYNC_FUNCTION,
        addEntry_entry: newEntry); //addEntry(newEntry);
    await _getEntries();
    return newEntry;
  }

  Future<void> _deleteEntry(int index) async {
    await _diaryController.callAsync(
        functionName: Controller.DELETE_ENTRY_ASYNC_FUNCTION,
        deleteEntry_entry: _entries[index]); //deleteEntry(_entries[index]);
    await _getEntries();
  }

  Future<void> _getEntries() async {
    final dataList = await _diaryController.callAsync(
        functionName: Controller.GET_ENTRIES_ASYNC_FUNCTION); //getEntries();
    _entries = dataList;
    print(_entries);
    notifyListeners();
  }

  Future<EntryViewModel> _getEntryById(String id) async {
    return await _diaryController.callAsync(
        functionName: Controller.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
        getEntryById_id: id);
  }

  void _updateCurrentText(String text) {
    _currentText = text;
    notifyListeners();
  }

  void _updateCurrentDate(DateTime date) {
    _currentDate = date;
    notifyListeners();
  }

  void _updateIsCurrentlySelected(bool isSelected) {
    _isCurrentlySelected = isSelected;
    notifyListeners();
  }
}
