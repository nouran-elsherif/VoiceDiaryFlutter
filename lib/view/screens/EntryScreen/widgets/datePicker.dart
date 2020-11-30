import 'dart:async';
import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  final Function onSelectDate;
  final DateTime selectedDate;
  MyDatePicker(
      {this.onSelectDate,
      this.selectedDate}); //{Key key, this.title}) : super(key: key);

  // final String title;

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onSelectDate(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print("Selecteeed date " + widget.selectedDate.toString());
    // DateTime tempDate =
    //     widget.selectedDate != null ? widget.selectedDate : selectedDate;
    // setState(() {
    //   selectedDate = tempDate;
    // });

    return Container(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Text("${selectedDate.toLocal()}".split(' ')[0]),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text("${selectedDate.toLocal()}".split(' ')[0]),
            ),
          ],
        ),
      ),
    );
  }
}
