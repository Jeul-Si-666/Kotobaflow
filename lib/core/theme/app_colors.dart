import 'package:flutter/material.dart';

/// Semantic color tokens for the Japanese Editorial Minimalism design system.
///
/// UI components must reference these tokens rather than hardcoded hex values.
abstract final class AppColors {
  // ── Light theme ────────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF5F1E8);
  static const Color lightSurface = Color(0xFFFFFCF6);
  static const Color lightPrimary = Color(0xFFB74735);
  static const Color lightTextPrimary = Color(0xFF282720);
  static const Color lightTextSecondary = Color(0xFF77756D);
  static const Color lightBorder = Color(0xFFE8DFD0);
  static const Color lightSuccess = Color(0xFF71836B);
  static const Color lightWarning = Color(0xFFC58B43);
  static const Color lightError = Color(0xFFB74735);

  // ── Dark theme ─────────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF20211F);
  static const Color darkSurface = Color(0xFF2B2C29);
  static const Color darkPrimary = Color(0xFFE47A62);
  static const Color darkTextPrimary = Color(0xFFF5F1E8);
  static const Color darkTextSecondary = Color(0xFFAAA79E);
  static const Color darkBorder = Color(0xFF41413B);
  static const Color darkSuccess = Color(0xFFA2B594);
  static const Color darkWarning = Color(0xFFD9AD69);
  static const Color darkError = Color(0xFFE47A62);
}
