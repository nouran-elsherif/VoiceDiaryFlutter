import 'package:flutter/foundation.dart';

import '../../models/entities/entryEntity.dart';

class EntryViewModel {
  String entryId;
  String entryText;
  DateTime entryDate;

  EntryViewModel({
    @required this.entryId,
    @required this.entryText,
    @required this.entryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': entryId,
      'entry_text': entryText,
      'entry_date': entryDate,
    };
  }

  static EntryViewModel fromMap(Map<String, dynamic> map) {
    return EntryViewModel(
      entryId: map['id'],
      entryText: map['entry_text'],
      entryDate: map['entry_date'],
    );
  }

  static EntryViewModel fromEntity(Entry entryEntity) {
    // print("ENTRYVIEWMODEEEEL from entity ");
    // print(entryEntity.entryDate);
    // print(entryEntity.entryDate)
    return EntryViewModel(
        entryId: entryEntity.entryId,
        entryText: entryEntity.entryText,
        entryDate: DateTime.fromMillisecondsSinceEpoch(entryEntity.entryDate));
  }
}
