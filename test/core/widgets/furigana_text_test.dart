import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kotobaflow/core/widgets/furigana_text.dart';

void main() {
  group('FuriganaText', () {
    testWidgets('renders plain text when kanji is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: FuriganaText(reading: 'する')),
        ),
      );

      expect(find.text('する'), findsOneWidget);
    });

    testWidgets('renders both kanji and reading when kanji is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FuriganaText(kanji: '食べる', reading: 'たべる'),
          ),
        ),
      );

      expect(find.text('食べる'), findsOneWidget);
      expect(find.text('たべる'), findsOneWidget);
    });

    testWidgets('hides reading when showFurigana is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FuriganaText(kanji: '本', reading: 'ほん', showFurigana: false),
          ),
        ),
      );

      expect(find.text('本'), findsOneWidget);
      expect(find.text('ほん'), findsNothing);
    });
  });
}
