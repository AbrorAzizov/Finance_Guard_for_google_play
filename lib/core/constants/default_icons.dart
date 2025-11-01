// lib/features/categories/data/default_categories.dart

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../features/categories/data/entity/category_entity.dart';

final List<CategoryEntity> defaultCategories = [
  CategoryEntity(
    id: const Uuid().v4(),
    name: "Food",
    iconCodePoint: Icons.restaurant.codePoint,
    iconFontFamily: Icons.restaurant.fontFamily,
    color: 0xFFFF9800, // Colors.orange
    isTracked: true,
  ),
  CategoryEntity(
    id: const Uuid().v4(),
    name: "Drink",
    iconCodePoint: Icons.local_drink.codePoint,
    iconFontFamily: Icons.local_drink.fontFamily,
    color: 0xFFF44336, // Colors.red
    isTracked: true,
  ),
  CategoryEntity(
    id: const Uuid().v4(),
    name: "Rent",
    iconCodePoint: Icons.home_work_outlined.codePoint,
    iconFontFamily: Icons.home_work_outlined.fontFamily,
    color: 0xFF9C27B0, // Colors.purple
    isTracked: true,
  ),
  CategoryEntity(
    id: const Uuid().v4(),
    name: "Car",
    iconCodePoint: Icons.directions_car.codePoint,
    iconFontFamily: Icons.directions_car.fontFamily,
    color: 0xFF3F51B5, // Colors.indigo
    isTracked: true,
  ),
];
