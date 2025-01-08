import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joystick_junkie/core/constants/jj_colors.dart';
import 'package:joystick_junkie/presentation/atoms/error_message.dart';

void main() {
  group('ErrorMessage Widget', () {
    testWidgets('should display the correct message and icon', (WidgetTester tester) async {
      // Arrange
      const testMessage = 'Something went wrong!';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorMessage(message: testMessage),
          ),
        ),
      );

      // Assert
      // Check if the Icon is displayed with correct properties
      final iconFinder = find.byIcon(Icons.warning);
      expect(iconFinder, findsOneWidget);

      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.color, JJColors.error);
      expect(iconWidget.size, 40);

      // Check if the Text is displayed with the correct message
      final textFinder = find.text(testMessage);
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, 16);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should have correct padding', (WidgetTester tester) async {
      // Arrange
      const testMessage = 'Padding test!';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorMessage(message: testMessage),
          ),
        ),
      );

      // Assert
      final paddingFinder = find.byType(Padding);
      expect(paddingFinder, findsOneWidget);

      final paddingWidget = tester.widget<Padding>(paddingFinder);
      expect(paddingWidget.padding, const EdgeInsets.all(8.0));
    });

    testWidgets('should have correct spacing between icon and text', (WidgetTester tester) async {
      // Arrange
      const testMessage = 'Spacing test!';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorMessage(message: testMessage),
          ),
        ),
      );

      // Assert
      final columnFinder = find.byType(Column);
      expect(columnFinder, findsOneWidget);

      final columnWidget = tester.widget<Column>(columnFinder);
      expect(columnWidget.spacing, 8); // Custom spacing defined in the widget
    });
  });
}
