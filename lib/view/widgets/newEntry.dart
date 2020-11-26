import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './datePicker.dart';
import './speechToText.dart';
import '../providers/diary_provider.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  // final Function _addEntry;
  String entryText;
  DateTime entryDate;

  void _setText(String text) {
    setState(() => entryText = text);
  }

  void _setDate(DateTime date) {
    setState(() => entryDate = date);
  }

  void _addEntry() {
    Provider.of<DiaryProvider>(context, listen: false)
        .addEntry(entryText, entryDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.all(10),
        // height: 300,
        child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // elevation: 5,
      child: Container(
          // height: 300,
          // crossAxisAlignment: CrossAxisAlignment.end,
          padding: EdgeInsets.all(10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MyDatePicker(
                onSelectDate: _setDate,
              ),
              SpeechScreen(
                setText: _setText,
              ),
              FloatingActionButton(
                onPressed: _addEntry,
                child: Text('Save'),
                backgroundColor: Colors.pinkAccent,
              ),

              // Text(entryText),
            ],
          )),
    ));
  }
}

// class NewEntry extends StatefulWidget {
//   final Function addEntry;
//   final String entryText = '';
//   // final DateTime entryDate;

//   NewEntry(this.addEntry);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       child: Container(
//           padding: EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               MyDatePicker(),

//               // Text(entryText),
//             ],
//           )),
//     );
//     // return Container(
//     //   width: double.infinity,
//     //   child: Text(
//     //     questionText,
//     //     style: TextStyle(fontSize: 28),
//     //     textAlign: TextAlign.center,
//     //   ),
//     // );
//   }
// }
