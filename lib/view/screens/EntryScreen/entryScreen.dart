import 'package:flutter/material.dart';

import './widgets/entryList.dart';
import './widgets/newEntry.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice Diary App"),
        backgroundColor: Colors.grey,

        // textTheme: TextTheme(bodyText1: Colors.black),
        actions: [],
      ),
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EntryList(),
          NewEntry(),
        ],
      ),
    );
  }
}
