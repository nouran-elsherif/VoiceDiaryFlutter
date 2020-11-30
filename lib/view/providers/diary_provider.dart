import 'package:flutter/foundation.dart';
import '../../models/entities/entryEntity.dart';
import '../../controller/diaryController.dart';
import '../constants/controllerFunctionNames.dart';

class DiaryProvider with ChangeNotifier {
  List<Entry> _entries = [];
  String _currentText = '';
  DateTime _currentDate = DateTime.now();
  Controller diaryController = Controller.instance;

  List<Entry> get entries {
    return [..._entries];
  }

  String get currentText {
    return _currentText;
  }

  DateTime get currentDate {
    return _currentDate;
  }

  void addEntry(String text, DateTime date) async {
    final newEntry = Entry(
        entryId: DateTime.now().toString(), entryText: text, entryDate: date);
    //_entries.add(newEntry);
    await diaryController.callAsync(
        function: DiaryControllerAsyncFunctions.addEntry,
        addEntryEntry: newEntry); //addEntry(newEntry);
    getEntries();
  }

  void deleteEntry(int index) async {
    await diaryController.callAsync(
        function: DiaryControllerAsyncFunctions.deleteEntry,
        deleteEntryEntry: _entries[index]); //deleteEntry(_entries[index]);
    getEntries();
  }

  Future<void> getEntries() async {
    final dataList = await diaryController.callAsync(
        function: DiaryControllerAsyncFunctions.getEntries); //getEntries();
    _entries = dataList;
    print(_entries);
    notifyListeners();
  }

  void updateCurrentText({String text}) {
    _currentText = text;
    notifyListeners();
  }

  void updateCurrentDate({DateTime date}) {
    _currentDate = date;
    notifyListeners();
  }
}
