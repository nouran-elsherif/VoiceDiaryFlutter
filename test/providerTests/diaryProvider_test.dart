// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voice_diary_app_flutter/view/providers/diary_provider.dart';
import 'package:voice_diary_app_flutter/view/models/entryViewModel.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final DiaryProvider provider = DiaryProvider();
  int countBeforeAdd, countAfterAdd, countAfterDelete;

  String entryId = DateTime.now().millisecondsSinceEpoch.toString();
  EntryViewModel newEntry = EntryViewModel(
      entryId: entryId, entryDate: DateTime.now(), entryText: "HELLOOOO");
  setUpAll(() async {
    await provider.callAsync(
        functionName: DiaryProvider.GET_ENTRIES_ASYNC_FUNCTION);
    countBeforeAdd = provider.entries.length;
    print(newEntry);
    newEntry = await provider.callAsync(
        functionName: DiaryProvider.ADD_ENTRY_ASYNC_FUNCTION,
        addEntry_text: newEntry.entryText,
        addEntry_date: newEntry.entryDate);
    entryId = newEntry.entryId;
    print(newEntry);
    await provider.callAsync(
        functionName: DiaryProvider.GET_ENTRIES_ASYNC_FUNCTION);
    countAfterAdd = provider.entries.length;
  });

  group('Add Entry', () {
    test('count', () {
      expect(countAfterAdd, countBeforeAdd + 1);
    });

    test('check type', () async {
      expect(
          (await provider.callAsync(
                  functionName: DiaryProvider.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
                  getEntryById_id: entryId))
              .runtimeType,
          EntryViewModel);
    });
    test('find by Id', () async {
      EntryViewModel entryvm = await provider.callAsync(
          functionName: DiaryProvider.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
          getEntryById_id: entryId);
      expect(entryvm.entryId, newEntry.entryId);
      expect(entryvm.entryText, newEntry.entryText);
      expect(entryvm.entryDate.millisecond, newEntry.entryDate.millisecond);
    });
  });
  group('Update Date', () {
    DateTime initialDate = provider.currentDate;
    test('Date at first', () {
      expect(provider.currentDate, initialDate);
    });

    test('check type of date', () {
      expect(provider.currentDate.runtimeType, DateTime);
    });

    test('update date and check', () {
      DateTime newDate = initialDate.add(new Duration(days: 2));
      provider.call(
          functionName: DiaryProvider.UPDATE_CURRENT_DATE_FUNCTION,
          updateCurrentDate_date: newDate);
      expect(provider.currentDate, newDate);
    });
  });

  group('Update Text', () {
    String initialText = provider.currentText;
    test('Text at first', () {
      expect(provider.currentText, '');

      expect(provider.currentText, initialText);
    });

    test('check type of Text', () {
      expect(provider.currentText.runtimeType, String);
    });

    test('update text and check', () {
      // DateTime newDate = initialDate.add(new Duration(days: 2));
      String newText = "Whateveeer";
      provider.call(
          functionName: DiaryProvider.UPDATE_CURRENT_TEXT_FUNCTION,
          updateCurrentText_text: newText);
      expect(provider.currentText, newText);
    });
  });

  group('delete entry', () {
    test('check entry first', () async {
      EntryViewModel entryvm = await provider.callAsync(
          functionName: DiaryProvider.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
          getEntryById_id: entryId);
      expect(entryvm.entryId, newEntry.entryId);
      // expect(entryvm.entryText, newEntry.entryText);
      expect(entryvm.entryDate.millisecond, newEntry.entryDate.millisecond);
    });
    test('delete entry and check count', () async {
      await provider.callAsync(
          functionName: DiaryProvider.DELETE_ENTRY_ASYNC_FUNCTION,
          deleteEntry_index: 0); //always in the future
      await provider.callAsync(
          functionName: DiaryProvider.GET_ENTRIES_ASYNC_FUNCTION);
      countAfterDelete = provider.entries.length;

      expect(countAfterDelete, countAfterAdd - 1);
      expect(countAfterDelete, countBeforeAdd);
    });
    test('check if entry still exists', () async {
      expect(
          await provider.callAsync(
              functionName: DiaryProvider.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
              getEntryById_id: entryId),
          null);
    });
  });
}
