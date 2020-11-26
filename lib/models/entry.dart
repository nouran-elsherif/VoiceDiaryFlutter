import 'package:flutter/foundation.dart';

class Entry {
  final String entryId;
  final String entryText;
  final DateTime entryDate;

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
}
