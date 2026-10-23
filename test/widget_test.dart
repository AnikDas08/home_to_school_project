import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_to_school/myapp.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final originalOnError = FlutterError.onError;
    final originalBuilder = ErrorWidget.builder;
    addTearDown(() {
      FlutterError.onError = originalOnError;
      ErrorWidget.builder = originalBuilder;
    });

    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 3));
    expect(find.byType(MyApp), findsOneWidget);
  });
}
