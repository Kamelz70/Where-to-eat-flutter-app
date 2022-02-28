import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final IconData icon;
  final String imageUrl;

  const Category(
      {required this.id,
      required this.title,
      required this.icon,
      required this.imageUrl});
}
