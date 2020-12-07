import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/diary_provider.dart';

class EntryList extends StatefulWidget {
  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.45,
        child: FutureBuilder(
          future: Provider.of<DiaryProvider>(context, listen: false).callAsync(
              functionName: DiaryProvider.GET_ENTRIES_ASYNC_FUNCTION),
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
                              subtitle: Container(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                    Text(entries.entries[i].entryText
                                        .toString()),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: FloatingActionButton(
                                          backgroundColor: Colors.grey,
                                          onPressed: () {
                                            Provider.of<DiaryProvider>(context,
                                                    listen: false)
                                                .callAsync(
                                                    functionName: DiaryProvider
                                                        .DELETE_ENTRY_ASYNC_FUNCTION,
                                                    deleteEntry_index: i);
                                          },
                                          child: Icon(Icons.delete)),
                                    )
                                  ])),
                              onTap: () {
                                Provider.of<DiaryProvider>(context,
                                        listen: false)
                                    .call(
                                        functionName: DiaryProvider
                                            .UPDATE_CURRENT_TEXT_FUNCTION,
                                        updateCurrentText_text:
                                            entries.entries[i].entryText);
                                Provider.of<DiaryProvider>(context,
                                        listen: false)
                                    .call(
                                        functionName: DiaryProvider
                                            .UPDATE_CURRENT_DATE_FUNCTION,
                                        updateCurrentDate_date:
                                            entries.entries[i].entryDate);
                                Provider.of<DiaryProvider>(context,
                                        listen: false)
                                    .call(
                                        functionName: DiaryProvider
                                            .UPDATE_IS_CURRENTLY_SELECTED_FUNCTION,
                                        updateIsCurrentlySelected_isSelected:
                                            true);
                                //update new entry part with date and text
                              }))),
        ));
  }
}
