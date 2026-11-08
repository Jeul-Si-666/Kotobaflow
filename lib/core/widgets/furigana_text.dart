import 'package:flutter/material.dart';

/// Renders Japanese vocabulary with Furigana (reading) displayed above the Kanji.
///
/// If [kanji] is absent or identical to [reading], renders [reading] directly.
/// Designed for the Japanese Editorial Minimalism aesthetic with clean vertical alignment.
class FuriganaText extends StatelessWidget {
  const FuriganaText({
    super.key,
    required this.reading,
    this.kanji,
    this.mainTextStyle,
    this.furiganaTextStyle,
    this.showFurigana = true,
  });

  /// The main reading in Hiragana or Katakana (e.g., 'たべる').
  final String reading;

  /// Optional Kanji representation (e.g., '食べる').
  final String? kanji;

  /// Text style applied to the primary word (Kanji or reading).
  final TextStyle? mainTextStyle;

  /// Text style applied to the small furigana text above the Kanji.
  final TextStyle? furiganaTextStyle;

  /// Whether to display the furigana ruby text above the Kanji.
  final bool showFurigana;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveMainStyle =
        mainTextStyle ?? theme.textTheme.titleLarge ?? const TextStyle();

    // If there is no kanji or kanji is identical to reading, render plain text
    if (kanji == null || kanji!.trim().isEmpty || kanji == reading) {
      return Text(reading, style: effectiveMainStyle);
    }

    final furiganaFontSize = (effectiveMainStyle.fontSize ?? 20) * 0.5;
    final effectiveFuriganaStyle =
        furiganaTextStyle ??
        theme.textTheme.labelSmall?.copyWith(
          fontSize: furiganaFontSize.clamp(9.0, 14.0),
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
          height: 1.1,
        ) ??
        TextStyle(fontSize: furiganaFontSize);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showFurigana)
          Text(
            reading,
            style: effectiveFuriganaStyle,
            textAlign: TextAlign.center,
          )
        else
          SizedBox(height: effectiveFuriganaStyle.fontSize ?? 10),
        Text(
          kanji!,
          style: effectiveMainStyle.copyWith(height: 1.2),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
