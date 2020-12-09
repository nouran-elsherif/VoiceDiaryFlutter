import 'package:flutter/foundation.dart';
import '../../view/models/entryViewModel.dart';

class Entry {
  final String entryId;
  final String entryText;
  final int entryDate;

  Entry({
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

  static Entry fromMap(Map<String, dynamic> map) {
    return Entry(
      entryId: map['id'],
      entryText: map['entry_text'],
      entryDate: map['entry_date'],
    );
  }

  static Entry fromViewModel(EntryViewModel entryViewModel) {
    // print("ENTITYYYY fromViewModel");
    // print(entryViewModel.entryDate.millisecondsSinceEpoch);
    return Entry(
      entryId: entryViewModel.entryId,
      entryText: entryViewModel.entryText,
      entryDate: entryViewModel.entryDate.millisecondsSinceEpoch,
    );
  }
}
