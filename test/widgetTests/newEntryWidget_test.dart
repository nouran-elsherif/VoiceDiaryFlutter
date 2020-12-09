import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voice_diary_app_flutter/main.dart';

import 'package:voice_diary_app_flutter/view/screens/EntryScreen/widgets/newEntry.dart';

void main() {
  testWidgets('Check new entry components', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.byType(NewEntry), findsOneWidget);
    // print("????");
    // print(find.byType(NewEntry));

    // check to see the buttons
    expect(find.byType(FloatingActionButton), findsNWidgets(2));
    expect(find.text('Save'), findsOneWidget);
    expect(find.byIcon(Icons.mic_none), findsOneWidget);

    //click on the record button the icon should change to mic
    await tester.tap(find.byIcon(Icons.mic_none));
    FloatingActionButton btn = find
        .widgetWithIcon(FloatingActionButton, Icons.mic_none)
        .evaluate()
        .first
        .widget;
    btn.onPressed();
    await tester.pump(const Duration(milliseconds: 300));

    //chech that we can't find the button with the icon
    expect(find.byIcon(Icons.mic_none), findsNothing);

    //check to see if the mic_none is there
    // expect(find.byIcon(Icons.mic), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
