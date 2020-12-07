// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voice_diary_app_flutter/models/models/entryModel.dart';
import 'package:voice_diary_app_flutter/models/entities/entryEntity.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final EntryModel model = EntryModel();
  int countBeforeAdd, countAfterAdd, countAfterDelete;
  String entryId = DateTime.now().millisecondsSinceEpoch.toString();
  Entry newEntry = Entry(
      entryId: entryId,
      entryDate: DateTime.now().millisecondsSinceEpoch,
      entryText: "HELLOOOO");

  setUpAll(() async {
    countBeforeAdd = (await model.getEntries()).length;
    model.addEntry(newEntry);
    countAfterAdd = (await model.getEntries()).length;
    // print(countBeforeAdd);
    // print(countAfterAdd);
  });

  group('Add Entry', () {
    test('count', () {
      expect(countAfterAdd, countBeforeAdd + 1);
    });
    test('find by Id', () async {
      Entry ent = await model.getEntryById(entryId);
      print("ENTRYYY ");
      print(ent);
      expect(ent.entryId, newEntry.entryId);
      expect(ent.entryText, newEntry.entryText);
      expect(ent.entryDate, newEntry.entryDate);
    });
  });

  group('upate entry', () {
    test('check if it exists first', () async {
      // expect((await model.getEntryById(entryId)), newEntry);
      Entry ent = await model.getEntryById(entryId);
      expect(ent.entryId, newEntry.entryId);
      expect(ent.entryText, newEntry.entryText);
      expect(ent.entryDate, newEntry.entryDate);
    });
    test('check text value', () async {
      expect((await model.getEntryById(entryId)).entryText, newEntry.entryText);
    });
    test('count after update', () async {
      Entry updatedEntry = Entry(
          entryId: newEntry.entryId,
          entryDate: newEntry.entryDate,
          entryText: "UPDATEEEEE");

      await model.update(updatedEntry);

      expect((await model.getEntries()).length, countAfterAdd);
    });
    test('check entry by id', () async {
      expect((await model.getEntryById(entryId)).entryText, "UPDATEEEEE");
    });
    test('check entry updated text type', () async {
      expect((await model.getEntryById(entryId)).entryText.runtimeType, String);
    });
  });

  group('delete entry', () {
    test('check entry first', () async {
      // expect(await model.getEntryById(entryId), newEntry);
      Entry ent = await model.getEntryById(entryId);
      expect(ent.entryId, newEntry.entryId);
      // expect(ent.entryText, newEntry.entryText);
      expect(ent.entryDate, newEntry.entryDate);
    });
    test('delete entry and check count', () async {
      await model.deleteEntry(newEntry);
      countAfterDelete = (await model.getEntries()).length;

      expect(countAfterDelete, countAfterAdd - 1);
      expect(countAfterDelete, countBeforeAdd);
    });
    test('check if entry still exists', () async {
      expect(await model.getEntryById(entryId), Null);
    });
  });
}
