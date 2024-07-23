import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gun/screens/on_logged_in/main_features/map_page.dart';

void main() {
  group('MapPage State', () {
    late MapPage mapPage;

    setUp(() {
      mapPage = MapPage();
    });

    testWidgets('Initial selectedIndex should be -1', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: mapPage));
      final mapScreenState = tester.state<MapScreenState>(find.byType(MapPage));
      expect(mapScreenState.selectedIndex, -1);
    });

    testWidgets('Initial map data length should match states length', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: mapPage));
      final mapScreenState = tester.state<MapScreenState>(find.byType(MapPage));
      expect(mapScreenState.mapData.length, 50);
    });

    testWidgets('updateSelectedIndex updates the correct map data colors', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: mapPage));
      final mapScreenState = tester.state<MapScreenState>(find.byType(MapPage));

      mapScreenState.updateSelectedIndex(2);
      await tester.pump();

      expect(mapScreenState.selectedIndex, 2);
      expect(mapScreenState.mapData[2].color, Colors.grey.shade50);

      mapScreenState.updateSelectedIndex(3);
      await tester.pump();

      expect(mapScreenState.selectedIndex, 3);
      expect(mapScreenState.mapData[2].color, Colors.red);
      expect(mapScreenState.mapData[3].color, Colors.grey.shade50);
    });

    testWidgets('Shape source updates correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: mapPage));
      final mapScreenState = tester.state<MapScreenState>(find.byType(MapPage));

      mapScreenState.updateShapeSource();
      await tester.pump();

      expect(mapScreenState.shapeSource.dataCount, 50);
      expect(mapScreenState.shapeSource.primaryValueMapper!(0), 'Alabama');
    });

    testWidgets('Dropdown button displays correct initial value', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: mapPage));

      expect(find.text('Select a State'), findsOneWidget);
    });

    testWidgets('Dropdown button updates selected index and shape source', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: mapPage));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Alaska').last);
      await tester.pumpAndSettle();

      final mapScreenState = tester.state<MapScreenState>(find.byType(MapPage));
      expect(mapScreenState.selectedIndex, 1);
      expect(mapScreenState.dropdownValue, 'Alaska');
    });
  });

  group('CustomDialogWidget', () {
    testWidgets('Dialog displays correct state data', (WidgetTester tester) async {
      final dialog = CustomDialogWidget(index: 2);  // Index of Arizona

      await tester.pumpWidget(MaterialApp(home: dialog));

      expect(find.text('Arizona'), findsOneWidget);
      expect(find.text('Pistols:'), findsOneWidget);
      expect(find.text('Rifles:'), findsOneWidget);
      expect(find.text('Shotguns:'), findsOneWidget);
    });
  });
}
