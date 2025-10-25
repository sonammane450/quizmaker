// Modern UI Constants with gradients and animations
import 'package:flutter/material.dart';

// Modern color palette
const Color primaryColor = Color(0xFF6366F1); // Indigo
const Color secondaryColor = Color(0xFF8B5CF6); // Purple
const Color accentColor = Color(0xFF06B6D4); // Cyan
const Color successColor = Color(0xFF10B981); // Emerald
const Color errorColor = Color(0xFFEF4444); // Red
const Color warningColor = Color(0xFFF59E0B); // Amber

// Gradient colors
const Color gradientStart = Color(0xFF667EEA);
const Color gradientEnd = Color(0xFF764BA2);
const Color cardGradientStart = Color(0xFFF8FAFC);
const Color cardGradientEnd = Color(0xFFE2E8F0);

// Text colors
const Color textPrimary = Color(0xFF1E293B);
const Color textSecondary = Color(0xFF64748B);
const Color textLight = Color(0xFF94A3B8);

// Background colors
const Color backgroundLight = Color(0xFFF8FAFC);
const Color backgroundDark = Color(0xFF0F172A);
const Color surfaceColor = Color(0xFFFFFFFF);
const Color surfaceVariant = Color(0xFFF1F5F9);

// Legacy color mappings for compatibility
const Color correct = successColor;
const Color incorrect = errorColor;
const Color neutral = textSecondary;
const Color background = backgroundLight;

// Modern gradients
const LinearGradient primaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [gradientStart, gradientEnd],
);

const LinearGradient cardGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [cardGradientStart, cardGradientEnd],
);

const LinearGradient successGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF10B981), Color(0xFF059669)],
);

const LinearGradient errorGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
);

// Modern shadows
const List<BoxShadow> cardShadow = [
  BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 10,
    offset: Offset(0, 4),
  ),
];

const List<BoxShadow> elevatedShadow = [
  BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 20,
    offset: Offset(0, 8),
  ),
];
