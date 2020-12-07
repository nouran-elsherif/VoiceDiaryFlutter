// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voice_diary_app_flutter/controller/diaryController.dart';
import 'package:voice_diary_app_flutter/view/models/entryViewModel.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Controller controller = Controller.instance;
  int countBeforeAdd, countAfterAdd, countAfterDelete;
  // List<Entry> entries = await model.getEntries();

  String entryId = DateTime.now().millisecondsSinceEpoch.toString();
  EntryViewModel newEntry = EntryViewModel(
      entryId: entryId, entryDate: DateTime.now(), entryText: "HELLOOOO");
  setUpAll(() async {
    countBeforeAdd = (await controller.callAsync(
            functionName: Controller.GET_ENTRIES_ASYNC_FUNCTION))
        .length;
    await controller.callAsync(
        functionName: Controller.ADD_ENTRY_ASYNC_FUNCTION,
        addEntry_entry: newEntry);
    countAfterAdd = (await controller.callAsync(
            functionName: Controller.GET_ENTRIES_ASYNC_FUNCTION))
        .length;
  });

  group('Add Entry', () {
    test('count', () {
      expect(countAfterAdd, countBeforeAdd + 1);
    });

    test('check type', () async {
      expect(
          (await controller.callAsync(
                  functionName: Controller.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
                  getEntryById_id: entryId))
              .runtimeType,
          EntryViewModel);
    });
    test('find by Id', () async {
      EntryViewModel entryvm = await controller.callAsync(
          functionName: Controller.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
          getEntryById_id: entryId);
      expect(entryvm.entryId, newEntry.entryId);
      expect(entryvm.entryText, newEntry.entryText);
      print(entryvm.entryDate.millisecond);
      expect(entryvm.entryDate.millisecond, newEntry.entryDate.millisecond);
    });
  });

  group('upate entry', () {
    test('check if it exists first', () async {
      EntryViewModel entryvm = await controller.callAsync(
          functionName: Controller.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
          getEntryById_id: entryId);
      expect(entryvm.entryId, newEntry.entryId);
      expect(entryvm.entryText, newEntry.entryText);
      expect(entryvm.entryDate.millisecond, newEntry.entryDate.millisecond);
    });
    test('check text value', () async {
      expect(
          (await controller.callAsync(
                  functionName: Controller.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
                  getEntryById_id: entryId))
              .entryText,
          newEntry.entryText);
    });
    test('count after update', () async {
      EntryViewModel updatedEntry = EntryViewModel(
          entryId: newEntry.entryId,
          entryDate: newEntry.entryDate,
          entryText: "UPDATEEEEE");

      controller.callAsync(
          functionName: Controller.UPDATE_ENTRY_ASYNC_FUNCTION,
          updateEntry_entry: updatedEntry);
      expect(
          (await controller.callAsync(
                  functionName: Controller.GET_ENTRIES_ASYNC_FUNCTION))
              .length,
          countAfterAdd);
    });
    test('check entry text updated', () async {
      expect(
          (await controller.callAsync(
                  functionName: Controller.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
                  getEntryById_id: entryId))
              .entryText,
          "UPDATEEEEE");
    });
  });

  group('delete entry', () {
    test('check entry first', () async {
      EntryViewModel entryvm = await controller.callAsync(
          functionName: Controller.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
          getEntryById_id: entryId);
      expect(entryvm.entryId, newEntry.entryId);
      // expect(entryvm.entryText, newEntry.entryText);
      expect(entryvm.entryDate.millisecond, newEntry.entryDate.millisecond);
    });
    test('delete entry and check count', () async {
      await controller.callAsync(
          functionName: Controller.DELETE_ENTRY_ASYNC_FUNCTION,
          deleteEntry_entry: newEntry);
      countAfterDelete = (await controller.callAsync(
              functionName: Controller.GET_ENTRIES_ASYNC_FUNCTION))
          .length;

      expect(countAfterDelete, countAfterAdd - 1);
      expect(countAfterDelete, countBeforeAdd);
    });
    test('check if entry still exists', () async {
      expect(
          await controller.callAsync(
              functionName: Controller.GET_ENTRY_BY_ID_ASYNC_FUNCTION,
              getEntryById_id: entryId),
          null);
    });
  });
}
