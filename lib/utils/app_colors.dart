import 'package:flutter/material.dart';

class AppColors {
  //Primary Islamic Colors - Premium Teal
  static const Color primary = Color(0xFF0D4D4D);
  static const Color primaryLight = Color(0xFF2E7D7D);
  static const Color primaryExtraLight = Color(0xFFE0F2F2);
  static const Color primaryDark = Color(0xFF072C2C);
  
  //Accent Colors - Elegant Gold
  static const Color accent = Color(0xFFC5A059);
  static const Color accentLight = Color(0xFFE5D1A6);
  static const Color accentDark = Color(0xFF8B6B23);
  
  //Background Colors
  static const Color background = Color(0xFFFBFBF9);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFEFD);
  
  //Glassmorphism effects
  static const Color glassBase = Color(0x33FFFFFF);
  static const Color glassBorder = Color(0x4DFFFFFF);
  
  //Text Colors
  static const Color textPrimary = Color(0xFF1A1C1E);
  static const Color textSecondary = Color(0xFF42474E);
  static const Color textLight = Color(0xFF72777F);
  static const Color arabicText = Color(0xFF002020);
  
  //Status Colors
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF0288D1);
  
  //Gradients
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFF0D4D4D), Color(0xFF1B5E20)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFC5A059), Color(0xFFE5D1A6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF1F1F1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
