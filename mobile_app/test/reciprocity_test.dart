import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gun/screens/on_logged_in/main_features/reciprocity.dart';
import 'package:syncfusion_flutter_maps/maps.dart';


void main() {
  testWidgets('ReciprocityPage initializes correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReciprocityPage()));

    // Check initial state of the dropdown
    expect(find.text('Select a Permit State'), findsOneWidget);

    // Verify that the map shape source is initialized
    final reciprocityPageState = tester.state<ReciprocityPageState>(
        find.byType(ReciprocityPage));
    expect(reciprocityPageState.shapeSource, isNotNull);
    expect(reciprocityPageState.mapData.length, equals(50));
  });

  testWidgets('Dropdown changes update state and map colors', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReciprocityPage()));

    // Tap the dropdown button to open the menu
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();

    // Tap on one of the items in the dropdown
    await tester.tap(find.text('Alabama'));
    await tester.pumpAndSettle();

    // Verify the dropdown value changes
    expect(find.text('Alabama'), findsOneWidget);

    // Verify that selectedIndex has changed
    final reciprocityPageState = tester.state<ReciprocityPageState>(
        find.byType(ReciprocityPage));
    expect(reciprocityPageState.selectedIndex, equals(0)); // Alabama has index 0
  });

  testWidgets('Map selection changes update state', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ReciprocityPage()));

    // Find the map widget
    final mapWidget = find.byType(SfMaps);
    expect(mapWidget, findsOneWidget);

    // Trigger a map selection change
    final reciprocityPageState = tester.state<ReciprocityPageState>(
        find.byType(ReciprocityPage));

    // Simulate selection change on the map
    reciprocityPageState.updateSelectedIndex(1); // Select the second index
    await tester.pump();

    // Check updated state
    expect(reciprocityPageState.selectedIndex, equals(1));
    expect(reciprocityPageState.dropdownValue, equals('Alaska')); // Alaska is at index 1
  });


 

}
