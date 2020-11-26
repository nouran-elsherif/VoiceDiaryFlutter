import 'package:flutter/foundation.dart';
import '../../models/entry.dart';
import '../../controller/diaryController.dart';

class DiaryProvider with ChangeNotifier {
  List<Entry> _entries = [];
  String _currentText = '';
  DateTime _currentDate = DateTime.now();

  List<Entry> get entries {
    return [..._entries];
  }

  void addEntry(String text, DateTime date) async {
    final newEntry = Entry(
        entryId: DateTime.now().toString(), entryText: text, entryDate: date);
    _entries.add(newEntry);
    Controller.addEntry(newEntry);
    _entries = await Controller.getEntries();
    notifyListeners();
  }

  Future<void> getEntries() async {
    final dataList = await Controller.getEntries();
    _entries = dataList;
    notifyListeners();
  }

  void updateCurrentEntry(Entry currentSelectedEntry) {
    _currentText = currentSelectedEntry.entryText;
    _currentDate = currentSelectedEntry.entryDate;
  }
}
