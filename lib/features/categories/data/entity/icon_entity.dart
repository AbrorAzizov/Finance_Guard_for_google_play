import 'package:flutter/material.dart';

class IconEntity {
  final String id;
  final int iconCodePoint;
  final String? iconFontFamily;
  final int color;

  IconEntity({
    required this.id,
    required this.iconCodePoint,
    required this.iconFontFamily,
    required this.color,
  });


  factory IconEntity.withColor({
    required String id,
    required IconData icon,
    required Color color,
  }) {
    return IconEntity(
      id: id,
      iconCodePoint: icon.codePoint,
      iconFontFamily: icon.fontFamily,
      // ignore: deprecated_member_use
      color: color.value, // automatic conversion
    );
  }
}
