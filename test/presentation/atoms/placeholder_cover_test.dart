import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joystick_junkie/presentation/atoms/placeholder_cover.dart';

void main() {
  group('PlaceholderCover', () {
    testWidgets('renders with default values', (WidgetTester tester) async {
      // Build the PlaceholderCover widget with default values
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlaceholderCover(),
          ),
        ),
      );

      // Check if the container has the correct size
      final container = find.byType(Container);
      final containerWidget = tester.widget<Container>(container);
      expect(containerWidget.constraints?.maxWidth, 200);
      expect(containerWidget.constraints?.maxHeight, 200);

      // Check if the icon is present with the correct size and color
      final icon = find.byType(Icon);
      final iconWidget = tester.widget<Icon>(icon);
      expect(iconWidget.size, 64); // Default icon size
      expect(iconWidget.color, Colors.grey); // Default icon color
    });

    testWidgets('renders with custom values', (WidgetTester tester) async {
      // Build the PlaceholderCover widget with custom values
      const customWidth = 300.0;
      const customHeight = 300.0;
      const customIconSize = 128.0;
      const customIcon = Icons.star;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PlaceholderCover(
              width: customWidth,
              height: customHeight,
              iconSize: customIconSize,
              icon: customIcon,
            ),
          ),
        ),
      );

      // Check if the container has the correct custom size
      final container = find.byType(Container);
      final containerWidget = tester.widget<Container>(container);
      expect(containerWidget.constraints?.maxWidth, customWidth);
      expect(containerWidget.constraints?.maxHeight, customHeight);

      // Check if the icon is present with the correct custom size and icon
      final icon = find.byType(Icon);
      final iconWidget = tester.widget<Icon>(icon);
      expect(iconWidget.size, customIconSize);
      expect(iconWidget.color, Colors.grey);
      expect(iconWidget.icon, customIcon); // Custom icon
    });
  });
}
