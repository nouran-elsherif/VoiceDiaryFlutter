import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/diary_provider.dart';

class EntryList extends StatefulWidget {
  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  // void _updateCurrentEntry() {
  //   Provider.of<DiaryProvider>(context, listen: false)
  //       .updateCurrentEntry(currentSelectedEntry);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: FutureBuilder(
            future:
                Provider.of<DiaryProvider>(context, listen: false).getEntries(),
            builder: (ctx, snapshot) => snapshot.connectionState ==
                    ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<DiaryProvider>(
                    child: Text('No entries yet'),
                    builder: (ctx, entries, ch) => entries.entries.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: entries.entries.length,
                            itemBuilder: (ctx, i) => ListTile(
                                title: Text(entries.entries[i].entryDate
                                    .toString()
                                    .split(' ')[0]),
                                subtitle: Text(
                                    entries.entries[i].entryText.toString()),
                                onTap: () {
                                  Provider.of<DiaryProvider>(context,
                                          listen: false)
                                      .updateCurrentEntry(entries.entries[i]);
                                  //update new entry part with date and text
                                }),
                          ))));
  }
}
