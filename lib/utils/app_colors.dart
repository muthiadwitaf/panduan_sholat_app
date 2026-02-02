import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Elegant Teal (Islamic Green)
  static const Color primary = Color(0xFF1D5F5F);
  static const Color primaryLight = Color(0xFF2A8A8A);
  static const Color primaryExtraLight = Color(0xFFE0F0F0);
  static const Color primaryDark = Color(0xFF0D3A3A);
  
  // Accent Colors - Royal Gold
  static const Color accent = Color(0xFFD4A84B);
  static const Color accentLight = Color(0xFFF5E6C8);
  static const Color accentDark = Color(0xFFB8923E);
  
  // Logo Background - Soft Sage Green
  static const Color logoBackground = Color(0xFFA5C89E);
  
  // Menu Icon Colors - Harmonious palette
  static const Color menuTeal = Color(0xFF2A8A8A);
  static const Color menuGold = Color(0xFFD4A84B);
  static const Color menuBlue = Color(0xFF4A7BA7);
  static const Color menuPurple = Color(0xFF7B68A6);
  static const Color menuRose = Color(0xFFB57B8C);
  
  // Background Colors - Warm & Soft
  static const Color background = Color(0xFFF8F5F0);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFEFC);
  
  // Glassmorphism effects
  static const Color glassBase = Color(0x33FFFFFF);
  static const Color glassBorder = Color(0x4DFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1A2E2E);
  static const Color textSecondary = Color(0xFF4A5F5F);
  static const Color textLight = Color(0xFF7A8F8F);
  static const Color arabicText = Color(0xFF0D3A3A);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF64B5F6);
  
  // Gradients
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFF1D5F5F), Color(0xFF2A8A8A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4A84B), Color(0xFFF5E6C8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F5F0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
