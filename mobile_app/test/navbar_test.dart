import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gun/screens/on_logged_in/main_features/armory_page.dart';
import 'package:gun/screens/on_logged_in/main_features/map_page.dart';
import 'package:gun/screens/on_logged_in/main_features/reciprocity.dart';
import 'package:gun/screens/on_logged_in/nav_components/drawer_components/create_drawer.dart';
import 'package:gun/screens/on_logged_in/nav_components/nav_bar_components/create_nav_bar.dart';


void main() {
  testWidgets('NavBar initial state', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: NavBar()));

    // Verify the initial state of the NavBar
    expect(find.byType(MapPage), findsOneWidget);
    expect(find.text('Concealed Carry Map'), findsOneWidget);
  });

  testWidgets('NavBar drawer opens and closes', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: NavBar()));

    // Open the drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify the drawer is opened
    expect(find.byType(MyDrawer), findsOneWidget);

    // Close the drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify the drawer is closed by checking the animation controller value
    expect(find.byType(MyDrawer), findsNothing);
  });

  testWidgets('NavBar navigation bar functionality', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: NavBar()));

    // Tap on the Armory navigation item
    await tester.tap(find.byIcon(Icons.cases_outlined));
    await tester.pumpAndSettle();

    // Verify the Armory screen is displayed
    expect(find.byType(Armory), findsOneWidget);
    expect(find.text('Armory'), findsOneWidget);

    // Tap on the Map navigation item
    await tester.tap(find.byIcon(Icons.map_outlined));
    await tester.pumpAndSettle();

    // Verify the Map screen is displayed
    expect(find.byType(MapPage), findsOneWidget);
    expect(find.text('Concealed Carry Map'), findsOneWidget);
  });

  testWidgets('NavBar reciprocity toggle button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: NavBar()));

    // Verify initial screen is MapPage
    expect(find.byType(MapPage), findsOneWidget);

    // Tap on the toggle button
    await tester.tap(find.text('Show Reciprocity'));
    await tester.pumpAndSettle();

    // Verify the ReciprocityPage is displayed
    expect(find.byType(ReciprocityPage), findsOneWidget);

    // Tap on the toggle button again
    await tester.tap(find.text('Show Concealed Carry'));
    await tester.pumpAndSettle();

    // Verify the MapPage is displayed
    expect(find.byType(MapPage), findsOneWidget);
  });
}
