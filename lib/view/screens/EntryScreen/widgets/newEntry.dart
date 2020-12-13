import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './datePicker.dart';
import './speechToText.dart';
import '../../../providers/diary_provider.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  // final Function _addEntry;
  String entryText;
  DateTime entryDate;

  void _updateIsCurrentlySelected() {
    Provider.of<DiaryProvider>(context, listen: false).call(
        functionName: DiaryProvider.UPDATE_IS_CURRENTLY_SELECTED_FUNCTION,
        updateIsCurrentlySelected_isSelected: false);
  }

  void _setText(String text) {
    setState(() => entryText = text);
    Provider.of<DiaryProvider>(context, listen: false).call(
        functionName: DiaryProvider.UPDATE_CURRENT_TEXT_FUNCTION,
        updateCurrentText_text: entryText);
    _updateIsCurrentlySelected();
  }

  void _setDate(DateTime date) {
    setState(() => entryDate = date);
    Provider.of<DiaryProvider>(context, listen: false).call(
        functionName: DiaryProvider.UPDATE_CURRENT_DATE_FUNCTION,
        updateCurrentDate_date: entryDate);
    _updateIsCurrentlySelected();
  }

  void _addEntry() {
    print("inside add entry new entry");
    Provider.of<DiaryProvider>(context, listen: false).callAsync(
        functionName: DiaryProvider.ADD_ENTRY_ASYNC_FUNCTION,
        addEntry_text: entryText,
        addEntry_date: entryDate);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        // margin: EdgeInsets.all(10),
        // height: MediaQuery.of(context).size.height * 0.5,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // elevation: 5,
          child: Container(
              // height: 300,
              // crossAxisAlignment: CrossAxisAlignment.end,
              padding: EdgeInsets.all(5),
              child: Container(
                  // flex: 1,
                  child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyDatePicker(
                    onSelectDate: _setDate,
                    selectedDate:
                        Provider.of<DiaryProvider>(context).currentDate,
                    isCurrentlySelected:
                        Provider.of<DiaryProvider>(context).isCurrentlySelected,
                  ),
                  SpeechScreen(
                    setText: _setText,
                    selectedText:
                        Provider.of<DiaryProvider>(context).currentText,
                    isCurrentlySelected:
                        Provider.of<DiaryProvider>(context).isCurrentlySelected,
                  ),
                  FloatingActionButton(
                    onPressed: _addEntry,
                    child: Text('Save'),
                    backgroundColor: Colors.pinkAccent,
                  ),

                  // Text(entryText),
                ],
              ))),
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
