import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voice_diary_app_flutter/main.dart';
import 'package:voice_diary_app_flutter/view/screens/EntryScreen/widgets/entryList.dart';

import 'package:voice_diary_app_flutter/view/screens/EntryScreen/widgets/newEntry.dart';

void main() {
  // testWidgets('Entry Screen components', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   expect(find.byType(NewEntry), findsOneWidget);
  //   expect(find.byType(EntryList), findsOneWidget);
  // });
  // testWidgets('Check new entry buttons if they exist',
  //     (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());
  //   expect(find.byType(FloatingActionButton), findsNWidgets(2));
  //   expect(find.text('Save'), findsOneWidget);
  //   expect(find.byIcon(Icons.mic_none), findsOneWidget);
  // });
  testWidgets('Check mic button click-change icon',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byIcon(Icons.mic_none));
    await tester.pump(const Duration(milliseconds: 2000));
    expect(find.byIcon(Icons.mic), findsOneWidget);
    expect(find.byIcon(Icons.mic_none), findsNothing);
  });
  // testWidgets('Check Save button click', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());
  //   //await tester.tap(find.byIcon(Icons.mic_none));
  //   FloatingActionButton btn = find
  //       .widgetWithText(FloatingActionButton, 'Save')
  //       .evaluate()
  //       .first
  //       .widget;
  //   btn.onPressed();
  //   await tester.pump(const Duration(milliseconds: 2000));
  //   //should check the new entry if it is found
  // });
  // testWidgets('Check ListItems', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());
  //   // check to see the buttons

  //   int listItems = find.byIcon(Icons.delete).allCandidates.length;
  //   print(listItems);
  //   print(find.byIcon(Icons.delete));
  //   // print(listItems);

  //   //not working because find.byIcon(Icons.delete) gets the ones visible only
  //   expect(find.byIcon(Icons.delete).allCandidates.length,
  //       findsNWidgets(listItems + 1));
  //   print('doneee');
  // });
  // testWidgets('Check delete of listItems', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   int listItems = find.byIcon(Icons.delete).allCandidates.length;
  //   print(listItems);
  //   await tester.tap(find.byIcon(Icons.delete).first);
  //   await tester.scrollUntilVisible(find.text("HELLOOO"), 2);
  //   await tester.pump(const Duration(milliseconds: 2000));
  //   expect(find.byIcon(Icons.delete).allCandidates.length,
  //       findsNWidgets(listItems - 1));
  // });
}
